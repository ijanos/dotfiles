# This script creates fish universal variables
# Run the script once and the variables will persist

set -U fish_user_paths ~/.local/bin/ ~/.multirust/toolchains/stable/cargo/bin/
set -Ux MANWIDTH 80
set -Ux EDITOR vim
set -Ux LESS -Ri
set -Ux AURDEST /tmp
