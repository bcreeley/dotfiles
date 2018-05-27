#!/bin/sh

# Author: Brett Creeley

usage_error() {
	local error_type=$1
	local error_text=$2

	if [ -z "$error_type" ]; then
		echo "Error: usage_error() requires an error_type argument"
		exit 1
	fi

	if [ -z "$error_text" ]; then
		echo "Error: usage_error() requires an error_text argument"
		exit 1
	fi

	case $error_type in
		missing_prog_error)
			echo "Error: Install $error_text to proceed" ;;
		github_pull_error)
			echo "Error: Failed to pull $error_text from github" ;;
		file_copy_error)
			echo "Error: Failed to copy $error_text to $HOME/" ;;
		vim_setup_error)
			echo "Error: Failed to setup $error_text" ;;
		*)
			echo "install.sh encountered unknown error ..." ;;
	esac

	exit 1
}

function check_for_error() {
	if [ $1 -ne 0 ]; then
		usage_error $2 $3
	fi
}

function echo_reminder() {
	if [ $1 -ne 0 ]; then
		echo $2
	fi
}

# Make sure git, curl, and vim are installed and keep stdout quiet
which git > /dev/null
check_for_error "$?" "missing_prog_error" "git"

which curl > /dev/null
check_for_error "$?" "missing_prog_error" "curl"

which vim > /dev/null
check_for_error "$?" "missing_prog_error" "vim"

# Try to copy all .vimrc to $HOME/ with confirmation of overwrite
cp -i ./.vimrc -t $HOME/
check_for_error "$?" "file_copy_error" ".vimrc"

# Try to git vim-plug from GitHub and make it quiet
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    > /dev/null 2>&1
check_for_error "$?" "github_pull_error" "plug.vim"

vim +'PlugInstall --sync' +qa
check_for_error "$?" "vim_setup_error" "vim-plug plugins"

git config --global core.editor "vim"

# Try to copy .tmux.conf to $HOME/ with confirmation of overwrite
cp -i ./.tmux.conf -t $HOME/
check_for_error "$?" "file_copy_error" ".tmux.conf"

cp -riu ./.vim/* ~/.vim/
check_for_error "$?" "vim_setup_error" "~/.vim/"

which tmux > /dev/null
echo_reminder "$?" "Don't forget to install tmux!"

which ctags > /dev/null
echo_reminder "$?" "Don't forget to install ctags!"

echo "install.sh success, dotfiles are configured!"
