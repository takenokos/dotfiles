#!/bin/bash

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

mkdir -p "zsh/.zsh/ohmyzsh-plugins-git"
wget -O "zsh/.zsh/ohmyzsh-plugins-git/git.plugin.zsh" https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/git/git.plugin.zsh
wget -O "zsh/.zsh/ohmyzsh-plugins-git/README.md" https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/git/README.md

mkdir -p ".config/git"
wget -O ".config/git/catppuccin.gitconfig" https://raw.githubusercontent.com/catppuccin/delta/refs/heads/main/catppuccin.gitconfig
cp ".config/git/.gitconfig" "git/.gitconfig"
read -p "git.user.name： " name
read -p "git.user.email： " email
git config --global user.name "$name"
git config --global user.email "$email"

mkdir -p ".config/bat/themes"
wget -O ".config/bat/themes/Catppuccin Macchiato.tmTheme" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme

mkdir -p ".config/bottom"
wget -O ".config/bottom/macchiato.toml" https://raw.githubusercontent.com/catppuccin/bottom/refs/heads/main/themes/macchiato.toml

mkdir -p ".config/gitui"
wget -O ".config/gitui/theme.ron" https://raw.githubusercontent.com/catppuccin/gitui/refs/heads/main/themes/catppuccin-macchiato.ron

echo "yazi"
mkdir -p ".config/yazi"
wget -O ".config/yazi/theme.toml" https://raw.githubusercontent.com/catppuccin/yazi/refs/heads/main/themes/macchiato/catppuccin-macchiato-blue.toml
sed -i "" "s|~/.config/yazi/Catppuccin-macchiato.tmTheme|~/.config/bat/themes/Catppuccin Macchiato.tmTheme|g" .config/yazi/theme.toml
ya pack -i


simple-completion-language-server fetch-external-snippets
cp .config/helix/languages.temp.toml .config/helix/languages.toml
sed -i "" "s|\$HOME|${HOME}|g" .config/helix/languages.toml

stow --dotfiles
stow zsh
stow git
stow --target=$HOME/.config .config

bat cache --build
