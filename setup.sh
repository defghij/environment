#! /bin/bash

echo "### Setting up environment ####"

# Get current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Current directory: $DIR"


# Copy the dot files to the home directory. 
echo "creating sym links: ~/<dot-files> -> $DIR"
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.tmux.conf ~/.tmux.conf



echo "#### Finished ####
