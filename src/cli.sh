source global_vars.sh
source throw.sh
source install.sh
source upgrade.sh
source help.sh
source usage.sh

cli() {

	subcommand="${1:-}"

	shift || true

	while getopts fdv option; do
	    case $option in
	        f)
	       		FORCE=1
	       		;;
	       	d)
	       		set -x
	       		;;
	       	v)
				VERBOSE=1
				;;
	        \?)
	            usage_show
	            throw "Wrong option [$@]"
	            ;;
    	esac
	done

	case $subcommand in
		i)
		    	;&
		install)
			install_run
			;;
		upgrade)
			upgrade_run
			;;
		version)
			echo "${FETCHDEPS_VERSION}"
			;;
		help)
			help_show
			;;
		*)
			usage_show
			if [[ "$subcommand" == "" ]]; then
				throw "Missing command"
			fi
			throw "Wrong command '$subcommand'"
			;;
	esac
}