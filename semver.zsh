emulate -L zsh

typeset -ga fpath

setopt LOCAL_OPTIONS EXTENDED_GLOB BARE_GLOB_QUAL

local fns="${${(%):-%x}:A:h}"/functions
local fn

if [ -d "$fns" ]; then
  fpath+=("$fns")
  for fn ("$fns"/*(.N:t))
    autoload -Uz -- "$fn"
fi
