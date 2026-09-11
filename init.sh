#!/bin/bash

source ~/.bashrc

if ! command -v stow &> /dev/null; then
    echo "stow could not be found"
    exit
fi

if ! command -v git &> /dev/null; then
    echo "git could not be found"
    exit
fi

if ! command -v wget &> /dev/null; then
    echo "wget could not be found"
    exit
fi

if ! command -v stow &> /dev/null; then
    echo "stow could not be found"
    exit
fi


if ! command -v simple-completion-language-server &> /dev/null; then
    echo "simple-completion-language-server could not be found"
    exit
fi

if ! command -v ya &> /dev/null; then
    echo "ya(yazi) could not be found"
    exit
fi

git submodule update --init --recursive

mkdir -p "zsh/.zsh/ohmyzsh-plugins-git"
wget -O "zsh/.zsh/ohmyzsh-plugins-git/git.plugin.zsh" https://ghproxy.net/raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/git/git.plugin.zsh --no-check-certificate
wget -O "zsh/.zsh/ohmyzsh-plugins-git/README.md" https://ghproxy.net/raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/git/README.md --no-check-certificate

git_user_name=$(git config --global user.name)
git_user_email=$(git config --global user.email)
mkdir -p ".config/git"
mkdir -p "git"
cp ".config/git/.gitconfig" "git/.gitconfig"

mkdir -p ".config/bat/themes"
wget -O ".config/bat/themes/Kanagawa.tmTheme" https://ghproxy.net/raw.githubusercontent.com/rebelot/kanagawa.nvim/refs/heads/master/extras/tmTheme/kanagawa.tmTheme --no-check-certificate

simple-completion-language-server fetch-external-snippets
cp .config/helix/languages.temp.toml .config/helix/languages.toml

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac
  sed -i "" "s|\$HOME|${HOME}|g" .config/helix/languages.toml
else
  # Linux
  sed -i "s|\$HOME|${HOME}|g" .config/helix/languages.toml
fi

stow -D zsh
stow zsh

stow -D git
stow git

stow -D --target=$HOME/.config .config
stow --target=$HOME/.config .config

bat cache --build

ya pkg install
ya pkg upgrade

if [ -z "$git_user_name" ]; then
  read -p "git.user.name： " name
  git config --global user.name "$name"
else
  git config --global user.name "$git_user_name"
fi

if [ -z "$git_user_email" ]; then
  read -p "git.user.email： " email
  git config --global user.email "$email"
else
  git config --global user.email "$git_user_email"
fi
