

# Run to Enable Firewall and Install Basic Packages Needed

```sh
sudo ufw enable

sudo apt install -y \
vim-gtk3 \
tmux \
git \
zsh \
curl \
fzf \
make \
npm \
xclip # needed for neovim to copy to system clipboard

sudo apt-get install -y \
ripgrep

# make zsh the shell default
# didn't quite work right away - have to log out and log back in
chsh -s $(which zsh)
```

-----

# Get dotfiles

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
# Add public key to GitHub, followed by:
cd ~/Documents
git clone git@github.com:breadoliveoilsalt/dotfiles.git

ln -fs ~/Documents/dotfiles/vim/.vimrc ~/.vimrc
ln -fs ~/Documents/dotfiles/zsh/.zshrc ~/.zshrc
ln -fs ~/Documents/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -fs ~/Documents/dotfiles/git/.gitconfig ~/.gitconfig
ln -fs ~/Documents/dotfiles/git/.gitignore_global ~/.gitignore_global
ln -fs ~/Documents/dotfiles/git/.git_template ~/.git_template
ln -fs ~/Documents/dotfiles/git/.git-prompt.sh ~/.git-prompt.sh
```

-----

# Install vim plug

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir ~/.vim/swap_files ~/.vim/backup_files ~/.vim/undo_files

-----

# Remap Keys To Mac Keyboard Layout

# https://help.ubuntu.com/community/Custom%20keyboard%20layout%20definitions
# https://help.ubuntu.com/community/Howto%3A%20Custom%20keyboard%20layout%20definitions/ht
```
sudo vim /usr/share/X11/xkb/symbols
```

Make modifications to file per below

```
// TN: original below
//key <ESC>  {  [ Escape    ] };
// TN: changed to:
key <ESC>  {  [ Caps_Lock   ] };

// TN: original below
// key <CAPS> { [ Caps_Lock   ] };
// TN: Changed to:
key <CAPS> {  [ Control_R   ] };

// TN: original below
// key <LCTL> { [ Control_L   ] };
// TN: changed to:
key <LCTL> {  [ Super_L   ] };

// TN: original below
// key <LWIN> { [ Super_L   ] };
// TN: changed to:
key <LWIN> {  [ Control_L   ] };

// TN: For mac laptop keyboard, I do NOT need to modify this one:
key <SUPR> { [ NoSymbol, Super_L ] };
// TN: unnecessary:
// key <SUPR> {  [ Control_L ] };
```

# Might not be necessary, but just in case
# https://help.ubuntu.com/community/Custom%20keyboard%20layout%20definitions
```
sudo rm -rf /var/lib/xkb/*xkm
```

Have to log in and out for changes to take effect

-----

# Install Neovim

Make sure to install ripgrep
To copy to system clipboard, make sure xclip is installed
Then you can copy to the `+` register and paste elsewhere

These don't quite seem to work:
- set clipboard+=unnamedplus
OR
- vim.api.nvim_set_option("clipboard","unnamed")
From:
https://www.reddit.com/r/neovim/comments/3fricd/easiest_way_to_copy_from_neovim_to_system/
https://askubuntu.com/questions/1486871/how-can-i-copy-and-paste-outside-of-neovim


------

## Install Latest Neovim

See neovim [installation from releases](https://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-2).

```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
```

This installs binaries `/opt/nvim-linux64/bin/`. Make sure to add this to `.zshrc`:

```sh
export PATH="$PATH:/opt/nvim-linux64/bin"
```

To examine checksum of downloaded tar file:

```sh
sha256sum nvim-linux64.tar.gz
```

-----

# Ubunutu Server

## Cheatsheet

### Basics

```sh
# Restart
sudo reboot

```

### Upgrade

https://ubuntu.com/server/docs/how-to-upgrade-your-release

```
sudo apt update
sudo apt upgrade
# To upgrade they system
sudo do-release-upgrade
```


### Setting up Git Server at Home Using ssh

- For user on server, note that note that Pro Git book and docs recommend creating a single `git` user for
  all users to clone/push to (this appears to be how github works).
- Add public keys from users/computers to ~/.ssh/authorized_keys
- Initialize bare repository for new projects. For example, to initialize for dotfiles:

```
# Server:

# ssh into server first
sudo mkdir -p /opt/git/dotfiles.git && cd /opt/git/dotfiles.git
sudo git init --bare
sudo git config --global init.defaultBranch main

# Make sure user can own repository everything in intitialized repo recursively
# https://stackoverflow.com/a/69016432
cd ..
sudo chown -R <user> dotfiles.git

# Reconsider after steps above:
# If warned about dubious ownership in repository
# git config --global --add safe.directory /opt/git/dotfiles.git

# Client with existing repository
git remote add home <user>@<host>:/opt/git/dotfiles.git
git push home <branch>

```

