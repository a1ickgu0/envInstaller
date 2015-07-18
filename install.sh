#!/bin/sh

if [ -f /etc/debian_version ]; then
is_deb=0;
else
is_deb=1;
fi

install_tools( )
{
	if [ $is_deb == 1 ]; then 
		apt-get -y install $2;
	else
		yum -y install $1;
	fi
}

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

#vim
cp -Rf ./vim/.vimrc ~/
cp -Rf ./vim/.vim ~/

#tmux
cp -f ./tmux/.tmux.conf ~/

#svn
if [ ! -d ~/.subversion ]; then
	mkdir ~/.subversion;
fi

cp -f ./subversion/config ~/.subversion

#git
cp -f ./git/.gitconfig ~/

