# bash will ignore this file if ~/.bash_profile exists

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-pkgs/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

export LESS=-Ri  # smart-case search and passing along escape characters (colorful grep)
export EDITOR=vim
export MANWIDTH=80
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
