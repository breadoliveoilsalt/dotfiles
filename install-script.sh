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
ln -fs ~/documents/dotfiles/vim/.vimrc ~/.vimrc
ln -fs ~/documents/dotfiles/zsh/.zshrc ~/.zshrc
ln -fs ~/documents/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -fs ~/documents/dotfiles/git/.gitconfig ~/.gitconfig
ln -fs ~/documents/dotfiles/git/.gitignore_global ~/.gitignore_global
ln -fs ~/documents/dotfiles/git/.git_template ~/.git_template
ln -fs ~/documents/dotfiles/git/.git-prompt.sh ~/.git-prompt.sh
ln -fs ~/documents/dotfiles/atom/config.cson ~/.atom/config.cson
ln -fs ~/documents/dotfiles/ctags/.ctags ~/.ctags
ln -fs rider/.ideavimrc ~/.ideavimrc
ln -fs ~/.vimrc ~/.ideavimrc
ln -fs ~/documents/dotfiles/prettier/.prettierrc ~/.prettierrc

ln -fs ~/documents/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -fs ~/documents/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# mkdir -p ~/.config/nvim
# ln -fs ~/documents/dotfiles/nvim/nvChad/init.lua ~/.config/nvim/init.lua

# Commands to open frequently used apps
# I should refactor this to a loop through the files
chmod +x ~/documents/dotfiles/customCommands/rider
ln -s ~/documents/dotfiles/customCommands/rider /usr/local/bin/rider

chmod +x ~/documents/dotfiles/customCommands/atom
ln -s ~/documents/dotfiles/customCommands/atom /usr/local/bin/atom

chmod +x ~/documents/dotfiles/customCommands/webstorm
ln -s ~/documents/dotfiles/customCommands/webstorm /usr/local/bin/webstorm

chmod +x ~/documents/dotfiles/customCommands/idea
ln -s ~/documents/dotfiles/customCommands/idea /usr/local/bin/idea

chmod +x ~/documents/dotfiles/customCommands/gitPruneBranches
ln -s ~/documents/dotfiles/customCommands/gitPruneBranches /usr/local/bin/gitPruneBranches

chmod +x ~/documents/dotfiles/customCommands/pngpaste
ln -s ~/documents/dotfiles/customCommands/pngpaste /usr/local/bin/pngpaste
# Generate new ssh key and add to ssh-agent
# See, e.g.:
# https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ln -s ~/documents/dotfiles/nonpublic/ssh/config ~/.ssh/config
ssh-add -K ~/.ssh/id_ed25519

# Specify iTerm configuration
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/documents/dotfiles/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# TODO: add clipboard app
