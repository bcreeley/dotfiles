#!/bin/sh

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

# Make sure git, curl, and vim are installed and keep stdout quiet
which git > /dev/null
if [ $? -ne 0 ]; then
	usage_error "missing_prog_error" "git"
fi

which curl > /dev/null
if [ $? -ne 0 ]; then
	usage_error "missing_prog_error" "curl"
fi

which vim > /dev/null
if [ $? -ne 0 ]; then
	usage_error "missing_prog_error" "vim"
fi

# Try to copy all .vimrc to $HOME/
cp -r ./.vimrc -t $HOME/
if [ $? -ne 0 ]; then
	usage_error "file_copy_error" "$PWD/*"
fi

# Try to git vim-plug from GitHub and make it quiet
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    > /dev/null 2>&1
if [ $? -ne 0 ]; then
	usage_error "github_pull_error" "plug.vim"
fi

vim +'PlugInstall --sync' +qa
if [ $? -ne 0 ]; then
	usage_error "vim_setup_error" "vim-plug plugins"
fi

git config --global core.editor "vim"

echo "install.sh success, dotfiles are configured!"

