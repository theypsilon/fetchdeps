source global_vars.sh
source confirm.sh
source throw.sh
source install.sh

upgrade_run() {
	(
		if [[ ! -f ${DEPS_UPGRADE} ]] ; then
			throw "'${0} upgrade' needs a ${DEPS_UPGRADE} file in the current folder"
		fi

		if [[ -d ${DEPS_FOLDER} ]] ; then
			echo
			echo "For upgrading dependencies, the old ones under '${DEPS_FOLDER}' need to be deleted first"
			confirm_wipe "$(pwd)/${DEPS_FOLDER}"
			echo
			rm -r ${DEPS_FOLDER}
		fi
		mkdir -p ${DEPS_FOLDER}
		cd ${DEPS_FOLDER}
		echo "Installing on $(pwd)" 1>&2

		echo "Reading ${DEPS_UPGRADE}" 1>&2
		local DEPS=$(cat ../${DEPS_UPGRADE})

		echo "$DEPS" | install_deps
		ls -d */ | upgrade_deps
	)
}

upgrade_deps() {
	rm ../${DEPS_INSTALL} 2> /dev/null || true
	while read -r folder ; do
		folder=${folder//\/}
		local installed_version=$(cat ${folder}/${DEPS_PERDEP_INSTALLED_FILE})
		echo "${folder}: ${installed_version}" >> ../${DEPS_INSTALL}
	done
	echo "Generated: ${DEPS_INSTALL} (this file should be under version control)"
}