envInststall
==

envInstall is a collection of my personal linux environment tools and configurations.

### Run script

Run `install.sh` with root privilege in `envInstaller` directory, the  script will auto install missing tools, including:

* vim
* tmux
* git
* subversion
* pip

Note: Only support apt & yum to install missing tools, because I only work in Debain(Ubuntu), CentOS and OS X(Homebrew).

### Custom configuration files

After script please replace some personal info such as account or email in follow configure file:

* git/.gitconfig, `name` and `email` in user section
* vim/.vimrc, `g:DoxygenToolkit_authorName` and `g:DoxygenToolkit_licenseTag`
