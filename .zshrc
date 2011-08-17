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
#setopt CORRECTALL

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
setopt share_history
#lets each of my shells use the same history file, and the file is updated
#after every command is run, so I no longer have to flick through each shell
#window wondering which one in particular contains the shell with a copy of the
#long command I ran in its history.

setopt autopushd               # press cd -<tab> and see the magic
setopt pushdignoredups         # and dont see duplicates

setopt ALWAYS_TO_END BASH_AUTO_LIST

setopt NO_CHECK_JOBS           # don't warn me about bg processes when exiting
setopt NO_HUP                  # and don't kill them, either
setopt LISTTYPES               # show types in completion

export PAGER='less -I'         # case insensitive less for manpages
export EDITOR=vim              # set editor

setopt extended_glob

# colorize stderr messages. Nice, but buggy :(
#exec 2>>(while read line; do
#  print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &)


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


# -----------------
# MISC
# -----------------

# set xterminals' title bar
chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%~\e\\"
      ;;
    *xterm*|*rxvt*|(dt|k|E)term) print -Pn "\e]2;% [zsh] %~ [%n@%m]\a"
      ;;
  esac
}

# -----------------
# COLORS
# -----------------
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
      #eval PR_$color='%{$terminfo[]$fg[${(L)color}]%}'
      eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
      #eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
      eval PR_LIGHT_$color='%{$terminfo[]$fg[${(L)color}]%}'
      (( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"

PROMPT='$PR_BLUE($PR_LIGHT_GREEN%~$PR_BLUE) %(!.$PR_RED.$PR_LIGHT_WHITE)%#$PR_NO_COLOUR '

# -----------------
# KEYBINDINGS
# -----------------
bindkey "\e[1~"  beginning-of-line
bindkey "\e[4~"  end-of-line
bindkey "\e[5~"  beginning-of-history
bindkey "\e[6~"  end-of-history
bindkey "\e[3~"  delete-char
bindkey "\e[2~"  quoted-insert
bindkey "\e[5C"  forward-word
bindkey "\eOc"   emacs-forward-word
bindkey "\e[5D"  backward-word
bindkey "\eOd"   emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H"     backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
#bindkey "\e[H" beginning-of-line

#bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix


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
alias -g BB="> /dev/null 2>&1 &!"
alias netstatmod='netstat --all --numeric --programs --inet'
alias dl='wget -c -t 0'

chpwd
