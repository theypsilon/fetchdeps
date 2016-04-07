#!/usr/bin/env bash
set -euo pipefail
IFS=$' '

source cli.sh

if [[ "${BASH_SOURCE[0]}" = "${0}" ]] ; then
	cli "$@"
fi
