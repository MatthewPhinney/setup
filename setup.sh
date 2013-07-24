#!/bin/bash
# setup.sh for configuring osx for development

# We assume the user has MacPorts installed
# Update MacPorts
sudo port selfupdate

# Use MacPorts to install basic commands
sudo port install tree
sudo port install wget

# Install git
sudo port install git-core +svn +doc +bash_completion +gitweb

# Install nvm: node-version manager
# https://github.com/creationix/nvm
# take script from github and pipe to sh for execution
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo port install rlwrap

# Install emacs
sudo port install emacs

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
if [ -f .emacs ]; then
    mv .emacs .emacs~
fi
if [ -f .bashrc ]; then
    mv .bashrc .bashrc~
fi
if [ -f .bash_profile ]; then
    mv .bash_profile .bash_profile~
fi

git clone https://github.com/MatthewPhinney/dotfiles.git
mv dotfiles/.bash_profile .
mv dotfiles/.bashrc .
mv dotfiles/.bashrc_custom .
mv dotfiles/.emacs.d .
