#!/usr/bin/env bash
set -euo pipefail
IFS=$' '

cd $(dirname "${BASH_SOURCE[0]}")

desource() {
	echo $(desource_recursive $1 "" | head -n -1)
}

desource_recursive() {
	local source_path=$1
	local acc=$2

	if [[ ! $acc =~ $source_path ]]; then
		acc=$acc";"$source_path
		while read line; do
			if [[ $line =~ ^[[:space:]]*source\ (.*\.sh)$ ]] ; then
				local content=$(desource_recursive "${BASH_REMATCH[1]}" $acc)
				line=$(echo $content | head -n -1)
				acc=$(echo $content | tail -n 1)
			fi
			echo $line
		done <<< $(cat $source_path)
	fi

	echo $acc
}

compile() {
	local version=$1
	local compiled_source=$(cd src; desource "main.sh")
	echo $compiled_source > fetchdeps
	sed -i "s/|UNKNOWN_VERSION|/$version/g" fetchdeps
	chmod +x fetchdeps
}

compile "development"