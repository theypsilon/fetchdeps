source global_vars.sh

throw() {
	echo "ERROR: $@" 1>&2
	exit 1
}

throw_format() {
	throw "Line $1 '$dep' does not follow the format '$DEPS_FILE_FORMAT'"
}