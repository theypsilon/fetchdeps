source global_vars.sh
source confirm.sh
source throw.sh

install_run() {
	(
		mkdir -p ${DEPS_FOLDER}
		cd ${DEPS_FOLDER}
		echo "Installing on $(pwd)" 1>&2

		if [[ ! -f ../${DEPS_INSTALL} ]] ; then
			throw "'${0} install' needs a ${DEPS_INSTALL} file in the current folder"
		fi

		echo "Reading ${DEPS_INSTALL}" 1>&2
		DEPS=$(cat ../${DEPS_INSTALL})

		echo "$DEPS" | install_deps
	)
}

install_git() {
	local repository="$1"
	local commit_id=""
	(
		if [[ $VERBOSE = 0 ]] ; then
			exec 1>> ../git-stdout.log
			exec 2>> ../git-stderr.log
		fi
		git clone $repository .
		git reset --hard $version
		commit_id=$(git rev-parse HEAD)
		rm -rf .git
	)
	echo $commit_id
}

install_get_version() {
	local repository=$1
	local commit_id=$2
	echo "${1}@${2}"
}

install_single_dep() {
	local folder=$1
	local repository=$2
	local version=$3

	local installed_file=${folder}/${DEPS_PERDEP_INSTALLED_FILE}
	local installed_version=$(install_get_version $repository $version)

	if [[ -d ${folder} ]] && [[ -f ${installed_file} ]] && [[ $(cat ${installed_file}) = $installed_version ]]; then
		echo -e "Ignoring: ${folder}\t(already installed)"
	else
	(
		echo -ne "Fetching: ${folder}"
		if [[ -d $folder ]]; then
			echo
			echo
			echo "For installing a new version of '${folder}', the old one needs to be deleted first"
			confirm_wipe "$(cd $folder; pwd)"
			echo
			rm -rf $folder > /dev/null 2>&1
		fi
		mkdir $folder
		cd $folder

		echo "$(install_get_version $repository $(install_git $repository))" > ${DEPS_PERDEP_INSTALLED_FILE}
		echo -e "\tOK -> $(pwd)"
	)
	fi
}

install_deps() {
	local i=$((0))
	while read -r dep ; do

		if [[ $dep =~ '^([^[:space:]]+*)\:\ ([^[:space:]]+*)@([^[:space:]]+*)$' ]] ; then
			install_single_dep "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}"
		else
			throw_format $i
		fi

		i=$((i + 1))
	done
}