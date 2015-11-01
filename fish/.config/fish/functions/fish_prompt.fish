function fish_prompt

  # simple root prompt
  if [ $USER = root ]
   printf '%s[root] %s%s %s➜ ' \
       (set_color -o red)\
       (set_color -o blue) (pwd)\
       (set_color -o red)
   return
  end

  if not set -q -g __prompt_helpers_defined
    set -g __prompt_helpers_defined
    function _git_branch_name
      echo (git rev-parse --symbolic-full-name --abbrev-ref HEAD ^/dev/null)
    end

    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end
  end

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  if [ (_git_branch_name) ]
    set -l branch_color $normal
    if [ (_is_git_dirty) ]
      set branch_color $red
    end
    set -l git_branch $branch_color(_git_branch_name)
    set git_info "$blue (git:$branch_color$git_branch$blue)"
  end

  if set -q -g VIRTUAL_ENV
     set -l ve_tag (basename "$VIRTUAL_ENV")
     set vex_info "$blue (venv:$normal$ve_tag$blue)"
  end

  if test -e "Cargo.toml"; and test -e /usr/local/bin/multirust;
    set -l c (set_color -o blue)
    set -l toolchain (multirust ctl override-toolchain)
    set multirust " $c(rust:$normal$toolchain$c)"
  end

  set -l arrow " $red➜ "
  set -l cwd $blue(basename (prompt_pwd))

  printf ' %s%s%s%s%s' \
     $cwd \
     $multirust \
     $vex_info \
     $git_info \
     $arrow
end
