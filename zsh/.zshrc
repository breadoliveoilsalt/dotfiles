# Add .NET Core SDK tools
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH:/Users/tonydistinti/.dotnet/tools"

# Disable ctrl+d...b/c I type it by accident too often, esp when scrolling down
# https://unix.stackexchange.com/questions/139115/disable-ctrl-d-from-closing-my-window-with-the-terminator-terminal-emulator
set -o ignoreeof

# This turns on vim keybindings for, eg, searching previous commands
# See: https://opensource.com/article/18/9/tips-productivity-zsh
bindkey -v

# Lets you edit command in vim. Hit space bar in visual mode
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

# Reconciles whatever turns of ctrl-r to search command history,
# So ctrl-r works again.
# See: https://superuser.com/questions/403355/how-do-i-get-searching-through-my-command-history-working-with-tmux-and-zshell
# bindkey '^R' history-incremental-search-backward

# https://unix.stackexchange.com/questions/30168/how-to-enable-reverse-search-in-zsh
# https://stackoverflow.com/questions/14040351/filtering-zsh-history-by-command
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# Stop homebrew from auto updating
export HOMEBREW_NO_AUTO_UPDATE=1

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Below adds whether vim mode is in insert or command mode to left prompt
# See: http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

# Git status only shows after entering normal mode, so this makes sure insert
# mode is inserted first and prompt does not jump
function vi_mode_prompt_info() {
  git_status=${${KEYMAP/vicmd/[% N] %}/(main|viins)/[% I] %}
  if [ -n "$git_status" ]; then
    echo "$git_status"
  else
    echo "[I]"
  fi
}

export get_git_branch() {
  git symbolic-ref --short HEAD 2> /dev/null | sed -e ""
}

# Need below to call method in prompt
setopt PROMPT_SUBST

# Prints === across the entire screen
# printDividingLineToEndOfWindow() {
#   echo
#   cols=$(tput cols)
#   for ((i=0; i<cols; i++));do printf "="; done; echo
# }

printDividingLineToEndOfWindow() {
  echo
  cols=80
  for ((i=0; i<cols; i++));do printf "="; done; echo
}

precmd() {
 printDividingLineToEndOfWindow
}

# The trick to getting the method to update each time was to surround the method
# call in single quotes.  I have no idea why. Without the external quotation marks,
# it kept returning the same branch every time. And double quotes would not
# work. Single quote are so important for some reason.
PROMPT='%F{green}>>>> %F{yellow}%1~ %F{green}($(get_git_branch)) %F{magenta}$(vi_mode_prompt_info) %f\$ '

# Print timestamp on right
# RPROMPT='$(date +%Y-%m-%d/%H:%M:%S)'
# export RPROMPT='%F{magenta}$(get_git_branch)%f'

alias ga="git add"
alias gaa="git add --all"
alias ga.="git add ."
alias gcm="git commit -m"
alias gc="git commit -v"
alias gs="git status"
alias gpo="git push origin"
alias gc="git checkout"
alias gcnb="git checkout -b"
alias gb="git branch"
alias glo="git log --oneline"
alias gl="git log"
alias lc="git log --oneline -1"
alias pullff="pull --ff-only"
alias gd="git diff"
alias gdc="git diff --cached"

# Works assuming you clone with https
# function openGitHubHttps() {
#   git remote -v | grep fetch | awk '{ print $2 }' | sed 's/\.git//' | xargs open
# }

# Assumes you connect to GitHub via SSH not https
function repo() {
  git remote -v | grep fetch | \
  awk '{ print $2 }' | sed 's/git@//' | \
  sed 's/:/\//' | sed 's/.git//' | \
  sed 's/^/https:\/\//' | xargs open
}

# Assumes you connect to GitHub via SSH not https
function prs() {
  git remote -v | grep fetch | \
    awk '{ print $2 }' | \
    sed '
      s/git@//
      s/:/\//
      s/.git//
      s/^/https:\/\//
      s/$/\/pulls/
    ' | xargs open
}

function myprs() {
  git remote -v | grep fetch | \
    awk '{ print $2 }' | \
    sed '
      s/git@//
      s/:/\//
      s/.git//
      s/^/https:\/\//
      s/$/\/pulls\/tdistinti/
    ' | xargs open
}

alias proj="cd ~/Documents/projects"
alias desktop="cd ~/Desktop"
alias docs="cd ~/Documents"
alias aproj="cd ~/Documents/projectsArchive/projectsApprenticeship"
alias blog="cd ~/Documents/projects/breadoliveoilsalt.github.io" 
alias ls="ls -lah"
alias reload="source ~/.zshrc"

alias lz="cd ~/Documents/projects/legalZoom"
alias iq="cd ~/Documents/projects/legalZoom/iq-flow"

# Think: Vim Last Session (vls)
alias vls='vim +"so Session.vim"'

# Automatically open Chrome with devtools in tabs.  Make sure all other Chrome
# windows are closed first
alias chromeWithDevTools='open -a "Google Chrome" --args --auto-open-devtools-for-tabs'

alias sqlpro="open -a 'SQLPro for MSSQL'"

# function tmuxExampleStartSessionAndJumpToDirectory() {
#   tmux new-session -d -s samaritan -n backend
#   tmux send-keys -t samaritan:backend "cd ~/Documents/projects/samaritan/backend; clear" Enter
#   tmux attach -t samaritan:backend
# }
#
# function tmuxExampleStartSessionAndOpenVim() {
#  tmux new-session -d -s dotfiles -n editPane
#  tmux send-keys -t dotfiles:editPane "cd ~/Desktop/projects/dotfiles; clear; vim ." Enter
#  tmux attach -t dotfiles:editPane
#  }

function dotfiles() {
  cd ~/Documents/dotfiles
  vim .
}

function atomNotes() {
  cd ~/Documents/atomNotes
  vim
# vim +"so Session.vim"
}

function start() {
  open -a "Activity Monitor"
  sleep 2
  open -a "Slack"
  sleep 2
  chromeWithDevTools "https://calendar.google.com"
}

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
zstyle :compinstall filename '/Users/tonydistinti/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# The last two lines above, in particular, are responsible for 
# running zsh's more powerfule autocompletion
# the matcher-list was taken from the scriptingos blog post below
# it works great and even seems to include partial string completion
# https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
# https://unix.stackexchange.com/questions/339954/zsh-command-not-found-compinstall-compinit-compdef
# IMP, to modify the stuff above, run: autoload -Uz compinstall && compinstall

# Include stuff in new .zsh directory, like git-completion
# Git completion for bash is required, see:
# https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

# Increase history size
# See: https://medium.com/macoclock/forced-to-use-zsh-by-macos-catalina-lets-fix-our-history-command-first-9ce86dca540e
setopt HIST_IGNORE_SPACE
HISTSIZE=99999
HISTFILESIZE=99999
SAVEHIST=$HISTSIZE
HISTORY_IGNORE='(pwd)'
# Add history alias to ensure starting from the beginning of history
alias histgrep="history 1 | grep"

# copy last command to clipboard
# alias clc="history -1 | sed 's/^[[:blank:]]*[0-9]*[[:blank:]]*//' | tr -d '\n' | pbcopy"
# Better:
# alias clc="history -1 | sed 's/^[[:blank:]]*[0-9]*[[:blank:]]*//' | sed 's/\\n/\n/g' | pbcopy"
# Best.  Works best as a function:
function clc() {
  history -1 | sed 's/^[[:blank:]]*[0-9]*[[:blank:]]*//' | sed 's/\\n/\n/g' | pbcopy
}

# function gitCommitsRecentOnThisNotThat() {
#   if [ $# -lt 2 ]; then
#     echo "You need to provide two branch names or two commits"
#     return
#   fi
# 
#   THIS=$1
#   echo "$1"
#   NOT_THAT=$2
#   echo "$2"
# 
#   IGNORE_EVERYTHING_BEFORE_THIS_COMMIT=$(git merge-base $NOT_THAT $THIS)
# 
#   echo "git log --oneline --no-merges $IGNORE_EVERYTHING_BEFORE_THIS_COMMIT $THAT"
#   git log --oneline --no-merges $IGNORE_EVERYTHING_BEFORE_THIS_COMMIT..$THAT
# }

function resetNode() {
  rm -rf node_modules
  npm install 
}

function resetDockerLZ() {
  docker stop nginx iq-flow && \
  docker rm nginx iq-flow 
}

# Takes object copied from browser and turns it into play js object
function transformJson() {
  pbpaste \
    | sed "
      s/\"//
      s/\"//
      s/\"/'/g
      /__typename/d
    " \
    | pbcopy
}

function stopDockerLZ() {
  cd apps/iq-flow
  docker compose down
  cd ../..
}

# Problem: this doesn't capture files that are new
function listFilesWithStatus {
  git status | grep : | sed -n '
    1d
    s/\t.*:[[:space:]]*//p
  '
}

function gitAddNumber {
  local tmp_sed_script=$(mktemp printLines.XXXXX)
  local line_number
  local git_file

  function action {
    while read git_file; do
      git add $git_file

      green='\033[0;32m'
      no_color='\033[0m'
      echo "Added ${green}${git_file}${no_color}"
    done
  }

  trap "rm -f $tmp_sed_script" EXIT SIGINT

  echo "#n" >> $tmp_sed_script

  for line_number in $@; do
    echo "${line_number}p" >> $tmp_sed_script
  done

  sed -f $tmp_sed_script <(listFilesWithStatus) | action
}

function gitRestoreNumber {
  local tmp_sed_script=$(mktemp printLines.XXXXX)
  local line_number
  local git_file

  function action {
    while read git_file; do
      git restore --staged $git_file

      local red='\033[0;31m'
      local no_color='\033[0m'
      echo "Unstaged ${red}${git_file}${no_color}"
    done
  }

  trap "rm -f $tmp_sed_script" EXIT SIGINT

  echo "#n" >> $tmp_sed_script

  for line_number in $@; do
    echo "${line_number}p" >> $tmp_sed_script
  done

  sed -f $tmp_sed_script <(listFilesWithStatus) | action
}

alias gan="gitAddNumber"
alias grn="gitRestoreNumber"

# allows asdf to work and read .tool-versions
# See meaning of dot here:
# https://unix.stackexchange.com/questions/114300/whats-the-meaning-of-a-dot-before-a-command-in-shell
# See also cat /usr/local/Cellar/asdf/0.9.0/libexec/asdf.sh
. /usr/local/opt/asdf/asdf.sh
. $HOME/.asdf/shims


# Load fzf shortcut keys:
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND="rg --files --hidden" 
