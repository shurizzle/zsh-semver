#!/usr/bin/env zsh

emulate -R zsh

set -eu

local me="${(%):-%x}"
local mydir="${me:a:h}"
export PATH="$mydir/bin:$PATH"

if [ ! -d "$mydir/zunit" ] || [ ! -d "$mydir/revolver" ]; then
  git -C "$mydir" submodule init
  git -C "$mydir" submodule update
fi

if ! [ -f "$mydir/zunit/zunit" ]; then
  pushd "$mydir/zunit"
  ./build.zsh || exit $?
  popd
fi

chmod +x "$mydir/zunit/zunit" "$mydir/revolver/revolver"

"$mydir/bin/zunit" run "$@"
