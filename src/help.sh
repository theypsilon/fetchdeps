source global_vars.sh
source usage.sh

help_show() {
	echo
	echo "FETCHDEPS VERSION: ${FETCHDEPS_VERSION}"
	echo
	echo -e "A cvs oriented dependency manager. Visit https://github.com/theypsilon/fetchdeps for more information."
	usage_show
	echo "EXAMPLES"
	echo -e "\t- $0 install"
	echo
	echo "AUTHOR"
	echo -e "\tJosé Manuel Barroso Galindo <theypsilon@gmail.com>"
	echo
	echo "COPYRIGHT"
	echo -e "\tLicense GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>"
	echo
}