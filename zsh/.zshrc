# This turns on vim keybindings for, eg, searching previous commands
# See: https://opensource.com/article/18/9/tips-productivity-zsh
bindkey -v

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Below adds whether vim mode is in insert or command mode to left prompt
# See: http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

function vi_mode_prompt_info() {
  # Git status only shows after entering normal mode, so 
  # this makes sure insert mode is inserted first and prompt 
  # does not jump
  git_status=${${KEYMAP/vicmd/[% N] %}/(main|viins)/[% I] %}
  if [ -n "$git_status" ]; then
    echo "$git_status"
  else
    echo "[I]"
  fi
    
# Prior versions
#  echo "${${KEYMAP/vicmd/[% NORMAL] %}/(main|viins)/[% INSERT] %}"
#  echo "${${KEYMAP/vicmd/[% N] %}/(main|viins)/[% I] %}" 
}

export get_git_branch() {
  git symbolic-ref --short HEAD 2> /dev/null | sed -e ""
}

# Need below to call method in prompt
setopt PROMPT_SUBST

# Prior prompt before adding vim command mode status
#PROMPT='%F{green}>>>> %F{yellow}%1~%f \$ '
PROMPT='%F{green}>>>> %F{yellow}%1~ %F{green}($(get_git_branch)) %F{magenta}$(vi_mode_prompt_info) %f\$ '

# The trick to getting the method to update each time was to surround the method
# call in single quotes.  I have no idea why. Without the external quotation marks,
# it kept returning the same branch every time. And double quotes would not
# work. Single quote are so important for some reason.
# export RPROMPT='%F{magenta}$(get_git_branch)%f'


alias grw="./gradlew"

alias ga="git add"
alias gaa="git add --all"
alias ga.="git add ."
alias gcm="git commit -m"
alias gc="git commit"
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

alias profile="vim ~/Desktop/projects/dotfiles/zsh/.zshrc"

alias proj="cd ~/Desktop/projects"
alias desktop="cd ~/Desktop"
alias docs="cd ~/Documents"
alias todo="cd ~/Documents/todo"
alias aproj="cd ~/Documents/projects-apprenticeship"
alias blog="cd ~/Desktop/projects/breadoliveoilsalt.github.io" 

alias ls="ls -lah"

# Think: Vim Last Session (vls)
alias vls='vim +"so Session.vim"'

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

# This makes the suggestion appear in line, roughly. See one of the answers
# here: https://unix.stackexchange.com/questions/84844/how-to-make-zsh-completion-show-the-first-guess-on-the-same-line-like-fish://unix.stackexchange.com/questions/84844/how-to-make-zsh-completion-show-the-first-guess-on-the-same-line-like-fishs
# autoload predict-on
# predict-on

# This turns on directory navigation without having to type `cd`
# See: https://opensource.com/article/18/9/tips-productivity-zsh
# setopt  autocd autopushd \ pushdignoredups => this generates error showing
setopt  autocd autopushd 

# allows asdf to work and read .tool-versions
. /usr/local/opt/asdf/asdf.sh

# load rbenv automatically
eval "$(rbenv init -)"

