# -----------------
# Autocomplete
# -----------------

autoload -Uz compinit
compinit
zstyle :compinstall filename '/home/ijanos/.zshrc'

# Use completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Do rehash before every completion
zstyle ":completion:*:commands" rehash 1

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric

# proper killall completion
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

compdef _pacman packer=pacman

# With commands like `rm' it's annoying if one gets offered the same filename
# again even if it is already on the command line. To avoid that:
zstyle ':completion:*:rm:*' ignore-line yes

# -----------------
# General settings
# -----------------

# Avoid globbing on special commands
for com in alias expr find mattrib mcopy mdir wget mdel which;
alias $com="noglob $com"

# Turns off C-S/C-Q flow control
setopt no_flow_control

# Turns off default -5 nice for programs send to background
setopt no_bgnice

# history settings
HISTFILE=~/.histfile
HISTSIZE=8000
SAVEHIST=8000
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt inc_append_history
setopt share_history
#lets each of my shells use the same history file, and the file is updated
#after every command is run, so I no longer have to flick through each shell
#window wondering which one in particular contains the shell with a copy of the
#long command I ran in its history.

setopt autopushd               # press cd -<tab> and see the magic
setopt pushdignoredups         # and dont see duplicates

setopt AUTO_LIST               # automatically list choices on an ambiguous completion

setopt NO_CHECK_JOBS           # don't warn me about bg processes when exiting
setopt NO_HUP                  # and don't kill them, either
setopt LISTTYPES               # show types in completion

setopt extended_glob

# -----------------
# Extract function
# -----------------

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}


# set terminal title bar
precmd() {print -Pn "\e]2;%4~\a"}


# Colors
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
autoload colors zsh/terminfo
eval `dircolors -b`

# Completion with colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

bindkey -e

# -----------------
# PROMPT
# -----------------
setopt prompt_subst

if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
      eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
      eval PR_LIGHT_$color='%{$terminfo[]$fg[${(L)color}]%}'
      (( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"

PROMPT='$PR_NO_COLOUR($PR_BLUE%~$PR_NO_COLOUR) %(!.$PR_RED#.$PR_LIGT_BLUE>)$PR_NO_COLOUR '

# -----------------
# KEYBINDINGS
# -----------------

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# -----------------
# ALIASES
# -----------------

alias ls='ls --color=auto -X'
alias ll='ls -lhX --group-directories-first'
alias ..='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."
alias df='df -Th -x tmpfs -x fuse -x usbfs -x devtmpfs'
alias ds='du -sh'
alias png='ping bix.hu'
alias tt='ls -Slrh|tail'
alias dtt='du -s *|sort -n|tail'
alias hdtt='du -s .*|sort -n|tail'
alias mv='mv -v -i'
alias cp='cp -v -i'
alias rm='rm -iv'
alias F='find . -iname'
alias topfiles='ls -lsR | sort -nr|less'
alias pacsize="pacman -Qi|awk '/^Installed Size/{print int(\$4), name} /^Name/{name=\$3}'|sort -nr|less"
alias dl='wget -c -t 0'
alias grep='grep --color=always'
alias photo-organizer='jhead -n%Y-%m-%d/%Y%m%d_%H%M%S *'
