source global_vars.sh

confirm() {
	if [[ $FORCE = 1 ]] ; then
		return 0
	fi
	echo "${1:-}"
	read -r -p "Are you sure? [y/N] (Use option -f to avoid this question)" response < /dev/tty
	case $response in
	    [yY][eE][sS]|[yY]) 
	        return 0
	        ;;
	    *)
	        throw "Aborted"
	        ;;
	esac
}

confirm_wipe() {
	confirm "This action will wipe completely the following folder: $1"
}