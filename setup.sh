#! /bin/bash

echo "### Setting up environment ####"

VIM_DFAULT_DIR="/usr/bin/vim"
TMUX_DFAULT_DIR="/usr/bin/tmux"

# Get current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Current directory: $DIR"

# Check that vim and tmux exist. If so then copy files
echo "Checking that Vim is installed"
if [ ! -f "$VIM_DFAULT_DIR" ]
  then
    echo "Vim is not installed."
    sudo apt get vim
  else 
    echo "Vim is installed"
fi
echo "Checking that TMux is installed"
if [ ! -f "$VIM_DFAULT_DIR" ]
  then
    echo "TMux is not installed."
    sudo apt get tmux
  else 
    echo "TMux is installed"
fi

# Copy the dot files to the home directory. 
echo "creating sym links: ~/<dot-files> -> $DIR"
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.tmux.conf ~/.tmux.conf

echo "Getting Vim addon manager Plug via curl"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Using Plug to install addons in the .vimrc"
vim blank -c PlugInstall -c quit -c quit


echo "#### Finished ####"
