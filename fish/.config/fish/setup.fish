# This script creates fish universal variables
# Run the script once and the variables will persist

# erase the user_paths to avoid duplicates
set -e fish_user_paths

set -U fish_user_paths ~/.local/bin/ $fish_user_paths
set -U fish_user_paths ~/.cargo/bin/ $fish_user_paths
set -U fish_user_paths ~/.npm-pkgs/bin $fish_user_paths
set -Ux MANWIDTH 80
set -Ux EDITOR vim
set -Ux LESS -Ri
set -Ux AURDEST /tmp
