#!/bin/bash

printf "Please enter your path \n"

read -r zsh_function_path

if [[ ! $zsh_function_path != "" ]]; then
	echo 'path of function can not null'
	exit 0
fi

echo '' >> ~/.zshrc
echo '# Custom zsh_functions blog' >> ~/.zshrc
echo "fpath=($zsh_function_path \$fpath)" >> ~/.zshrc
echo 'autoload -U $fpath[1]/*(.:t)' >> ~/.zshrc
echo '' >> ~/.zshrc

echo "your are set zsh_functions path as: $zsh_function_path"
echo "Please make sure is correctly, then you can use your custom functions"
