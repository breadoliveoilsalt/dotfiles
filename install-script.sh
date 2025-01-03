#!/bin/sh
set -Eeou pipefail

# Install xcode command line tools like git etc.
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Only install with brew if (1) you really trust brew and  (2) auto updates are not a problem
brew install vim
brew install tmux
brew install asdf
brew install jq
brew install tree
brew install pstree
brew install ctags
# brew install rbenv
brew install fzf
brew install fsouza/prettierd/prettierd
# brew install tmate
brew install --cask iterm2
# brew install --cask firefox
# brew install neovim
brew install --cask atom
brew install --cask rider
brew install --cask postman
brew install --cask slack
brew install --cask docker
brew install --cask zoom
brew install --cask evernote
# brew install --cask sqlpro-for-mssql

mkdir -p ~/.vim/{backup_files,swap_files,undo_files}

# Symlinks
# Note that relative paths did not seem to work, eg: ln -s vim/.vimrc ~/.vimrc
# I should refactor this to a loop through the files
ln -fs ~/Documents/dotfiles/vim/.vimrc ~/.vimrc
ln -fs ~/Documents/dotfiles/zsh/.zshrc ~/.zshrc
ln -fs ~/Documents/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -fs ~/Documents/dotfiles/git/.gitconfig ~/.gitconfig
ln -fs ~/Documents/dotfiles/git/.gitignore_global ~/.gitignore_global
ln -fs ~/Documents/dotfiles/git/.git_template ~/.git_template
ln -fs ~/Documents/dotfiles/git/.git-prompt.sh ~/.git-prompt.sh
ln -fs ~/Documents/dotfiles/atom/config.cson ~/.atom/config.cson
ln -fs ~/Documents/dotfiles/ctags/.ctags ~/.ctags
ln -fs rider/.ideavimrc ~/.ideavimrc
ln -fs ~/.vimrc ~/.ideavimrc
ln -fs ~/Documents/dotfiles/prettier/.prettierrc ~/.prettierrc

ln -fs ~/Documents/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -fs ~/Documents/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# mkdir -p ~/.config/nvim
# ln -fs ~/Documents/dotfiles/nvim/nvChad/init.lua ~/.config/nvim/init.lua

# Commands to open frequently used apps
# I should refactor this to a loop through the files
chmod +x ~/Documents/dotfiles/customCommands/rider
ln -s ~/Documents/dotfiles/customCommands/rider /usr/local/bin/rider

chmod +x ~/Documents/dotfiles/customCommands/atom
ln -s ~/Documents/dotfiles/customCommands/atom /usr/local/bin/atom

chmod +x ~/Documents/dotfiles/customCommands/webstorm
ln -s ~/Documents/dotfiles/customCommands/webstorm /usr/local/bin/webstorm

chmod +x ~/Documents/dotfiles/customCommands/idea
ln -s ~/Documents/dotfiles/customCommands/idea /usr/local/bin/idea

chmod +x ~/Documents/dotfiles/customCommands/gitPruneBranches
ln -s ~/Documents/dotfiles/customCommands/gitPruneBranches /usr/local/bin/gitPruneBranches

chmod +x ~/Documents/dotfiles/customCommands/pngpaste
ln -s ~/Documents/dotfiles/customCommands/pngpaste /usr/local/bin/pngpaste
# Generate new ssh key and add to ssh-agent
# See, e.g.:
# https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ln -s ~/Documents/dotfiles/nonpublic/ssh/config ~/.ssh/config
ssh-add -K ~/.ssh/id_ed25519

# Specify iTerm configuration
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/Documents/dotfiles/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# TODO: add clipboard app
