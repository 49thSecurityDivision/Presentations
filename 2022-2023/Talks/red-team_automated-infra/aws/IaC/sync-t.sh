#!/usr/bin/env bash

# https://elrey.casa/bash/scripting/harden
set -${-//[sc]/}eu${DEBUG+xv}o pipefail

function main(){
  SCRIPTPATH="$( cd "$(dirname "$(readlink -f "$0")")" >/dev/null 2>&1 ; pwd -P )"
  source "${SCRIPTPATH}/shared.sh"

  functions=(
    't_create'
  )

  for functionz in "${functions[@]}" ; do
    run_func "${functionz}"
  done
}

# https://elrey.casa/bash/scripting/main
if [[ "${0}" = "${BASH_SOURCE[0]:-bash}" ]] ; then
  main "${@}"
fi
