#!/bin/bash

export ZSH_FUNCTION_PATH=~/custom_zsh
mkdir $ZSH_FUNCTION_PATH
cp ./* $ZSH_FUNCTION_PATH
echo '' >> ~/.zshrc
echo '# Custom zsh_functions blog' >> ~/.zshrc
echo "fpath=($ZSH_FUNCTION_PATH \$fpath)" >> ~/.zshrc
echo 'autoload -U $fpath[1]/*(.:t)' >> ~/.zshrc
echo '' >> ~/.zshrc

echo "your are set zsh_functions path as: $ZSH_FUNCTION_PATH"
echo "Please make sure is correctly, then you can use your custom functions"
