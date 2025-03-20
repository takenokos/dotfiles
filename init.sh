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
wget -O "zsh/.zsh/ohmyzsh-plugins-git/git.plugin.zsh" https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/git/git.plugin.zsh
wget -O "zsh/.zsh/ohmyzsh-plugins-git/README.md" https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/git/README.md

git_user_name=$(git config --global user.name)
git_user_email=$(git config --global user.email)
mkdir -p ".config/git"
mkdir -p "git"
wget -O ".config/git/catppuccin.gitconfig" https://raw.githubusercontent.com/catppuccin/delta/refs/heads/main/catppuccin.gitconfig
cp ".config/git/.gitconfig" "git/.gitconfig"

mkdir -p ".config/bat/themes"
wget -O ".config/bat/themes/Catppuccin Macchiato.tmTheme" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme

mkdir -p ".config/bottom"
wget -O ".config/bottom/macchiato.toml" https://raw.githubusercontent.com/catppuccin/bottom/refs/heads/main/themes/macchiato.toml

mkdir -p ".config/gitui"
wget -O ".config/gitui/theme.ron" https://raw.githubusercontent.com/catppuccin/gitui/refs/heads/main/themes/catppuccin-macchiato.ron

echo "yazi"
mkdir -p ".config/yazi"
wget -O ".config/yazi/theme.toml" https://raw.githubusercontent.com/catppuccin/yazi/refs/heads/main/themes/macchiato/catppuccin-macchiato-blue.toml

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac
  sed -i "" "s|~/.config/yazi/Catppuccin-macchiato.tmTheme|~/.config/bat/themes/Catppuccin Macchiato.tmTheme|g" .config/yazi/theme.toml
else
  # Linux
  sed -i "s|~/.config/yazi/Catppuccin-macchiato.tmTheme|~/.config/bat/themes/Catppuccin Macchiato.tmTheme|g" .config/yazi/theme.toml
fi

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

ya pack -i
ya pack -u

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
