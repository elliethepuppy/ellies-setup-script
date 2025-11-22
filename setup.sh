#!/usr/bin/bash

programlist=$(< programlist.txt)
flatpaklist=$(< flatpaklist.txt)

echo "Installing packages from DNF"
sudo dnf install $programlist -y

echo "Installing packages from flatpak"
sudo flatpak install $flatpaklist

echo "Installing Lunarvim"
./lvim_install.sh

echo "Setting lvim background transparency"
if grep -q "lvim.transparent_window" "$HOME/.config/lvim/config.lua"; then
  echo "Already set"
else
  echo "lvim.transparent_window = true" >> $HOME/.config/lvim/config.lua
fi

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


echo "Setting EDITOR variable to lvim"
export EDITOR=$HOME/.local/bin/lvim

