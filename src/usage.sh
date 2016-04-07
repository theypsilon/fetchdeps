source global_vars.sh

usage_show() {
	echo
	echo "Usage: [ENV] ${0} <command> [OPTION]"
	echo
	echo "where <command> is one of:"
	echo -e "\tinstall \t Fetches all the dependencies from '${DEPS_INSTALL}' in '${DEPS_FOLDER}' folder."
	echo -e "\t\t\t   Running this command should produce always the the same outcome in all environments"
	echo -e "\t\t\t   You will want to run this command after a fresh clone or after pulling changes from the repository"
	echo -e "\ti \t\t Alias of <install>"
	echo -e "\tupgrade \t Same as <install> but using '${DEPS_UPGRADE}', also generates '${DEPS_INSTALL}' with all the fixed versions"
	echo -e "\t\t\t   Running this command will upgrade already fetched dependencies to a newer version if available"
	echo -e "\t\t\t   You should not do run this command in your build process, use <install> instead"
#	echo -e "\tadd NAME URI \t Adds 'NAME' dependency with 'URI' location to '${DEPS_UPGRADE}'"
#	echo -e "\tremove NAME \t Removes 'NAME' dependency from '${DEPS_UPGRADE}'"
#	echo -e "\tlist \t\t Lists all the dependencies"
	echo -e "\tversion \t Shows the current version of this program"
	echo -e "\thelp \t\t Shows the help"
	echo
	echo "where [ENV] are the following environment variables:"
	echo -e "\tFETCHDEPS_INSTALL_FILE=file \t Specifies the file readed during <install>"
	echo -e "\t\t\t\t\t (default: FETCHDEPS_INSTALL_FILE=${INSTALLFILE_DEFAULT})"
	echo -e "\tFETCHDEPS_UPGRADE_FILE=file \t Specifies the file readed during <upgrade>"
	echo -e "\t\t\t\t\t (default: FETCHDEPS_UPGRADE_FILE=${UPGRADEFILE_DEFAULT})"
	echo -e "\tFETCHDEPS_DEPS_FOLDER=folder \t Specifies the folder where all the dependencies will be downloaded"
	echo -e "\t\t\t\t\t (default: FETCHDEPS_DEPS_FOLDER=${DEPSFOLDER_DEFAULT})"
	echo
	echo "where [OPTION] is one of:"
	echo -e "\t-f \t Will stop asking for user confirmation when there is at action that removes folders under '${DEPS_FOLDER}'"
	echo -e "\t-v \t Verbose mode"
	echo -e "\t-d \t Debug mode"
	echo
}