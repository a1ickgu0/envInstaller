#!/bin/sh

# Install tools
YUM_CMD=$(command -v yum)
APT_CMD=$(command -v apt-get)
BREW_CMD=$(command -v brew)

install_tools( )
{
	if [ -n "${YUM_CMD}" ]; then
		sudo yum -y install $1;
	elif [ -n "${APT_CMD}" ]; then
		sudo apt-get -y install $1;
	elif [ -n "${BREW_CMD}" ]; then
		brew install $1;
	fi
}

#Init submodule
git submodule init
git submodule update

#Install tools
if ! type vim > /dev/null ; then
	install_tools "vim";
fi

if ! type svn > /dev/null ; then
	install_tools "subversion";
fi

if ! type tmux > /dev/null ; then
	install_tools "tmux";
fi

if ! type make > /dev/null ; then
	install_tools "build-essential libssl-dev libncurses5-dev unzip"
fi

#vim
cp -Rf ./vim/.vimrc ~/
cp -Rf ./vim/.vim ~/
vim +PluginInstall +qall

#tmux
cp -f ./tmux/.tmux.conf ~/

#svn
if [ ! -d ~/.subversion ]; then
	mkdir ~/.subversion;
fi

cp -f ./subversion/config ~/.subversion

#git
cp -f ./git/.gitconfig ~/
