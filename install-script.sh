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
# brew install fzf
# brew install tmate
brew install --cask iterm2
brew install --cask firefox
brew install --cask atom
brew install --cask rider
brew install --cask boost-note
brew install --cask postman
brew install --cask slack
brew install --cask docker
brew install --cask zoom
brew install --cask evernote
brew install --cask sqlpro-for-mssql

# Symlinks
# Note that relative paths did not seem to work, eg: ln -s vim/.vimrc ~/.vimrc
ln -s ~/Documents/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/Documents/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/Documents/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/Documents/dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/Documents/dotfiles/git/.gitignore_global ~/.gitignore_global
ln -s ~/Documents/dotfiles/git/.git_template ~/.git_template
ln -s ~/Documents/dotfiles/git/.git-prompt.sh ~/.git-prompt.sh

# Commands to open frequently used apps
chmod +x ~/Documents/dotfiles/customCommands/rider
ln -s ~/Documents/dotfiles/customCommands/rider /usr/local/bin/rider

chmod +x ~/Documents/dotfiles/customCommands/atom
ln -s ~/Documents/dotfiles/customCommands/atom /usr/local/bin/atom

# Generate new ssh key and add to ssh-agent
# See, e.g.:
# https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ln -s ~/Documents/dotfiles/ssh/config ~/.ssh/config
ssh-add -K ~/.ssh/id_ed25519

# Specify iTerm configuration
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/Documents/dotfiles/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
