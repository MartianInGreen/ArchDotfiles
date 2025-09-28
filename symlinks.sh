#!/bin/bash

# ---------------------------------------------------------
# Non-Symlink Backup of old files
# ---------------------------------------------------------

mkdir -p ~/.old_files 
mkdir -p ~/.old_files/.config

mkdir -p ~/.old_files/.config/alacritty

# ---------------------------------------------------------
# Misc symlinks
# ---------------------------------------------------------


# ---------------------------------------------------------
# Home directory symlinks
# ---------------------------------------------------------

# Zsh
mv ~/.zshrc ~/.old_files/.zshrc
mv ~/.p10k.zsh ~/.old_files/.p10k.zsh
ln -s ~/.arch/dotfiles/homedir/.zshrc ~/.zshrc
ln -s ~/.arch/dotfiles/homedir/.p10k.zsh ~/.p10k.zsh

# Bash
mv ~/.bashrc ~/.old_files/.bashrc
ln -s ~/.arch/dotfiles/homedir/.bashrc ~/.bashrc

# Git
mv ~/.gitconfig ~/.old_files/.gitconfig
ln -s ~/.arch/dotfiles/homedir/.gitconfig ~/.gitconfig

# ---------------------------------------------------------
# Home/.config directory symlinks
# ---------------------------------------------------------

# Alacritty
mkdir -p ~/.config/alacritty
mv ~/.config/alacritty/alacritty.toml ~/.old_files/.config/alacritty/alacritty.toml
ln -s ~/.arch/dotfiles/home_config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

# Cosmic
mv ~/.config/cosmic ~/.old_files/.config/
ln -s ~/.arch/dotfiles/home_config/cosmic ~/.config/

# Fastfetch
mv ~/.config/fastfetch ~/.old_files/.config/fastfetch
ln -s ~/.arch/dotfiles/home_config/fastfetch ~/.config/