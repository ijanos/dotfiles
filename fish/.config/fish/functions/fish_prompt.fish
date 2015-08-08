function fish_prompt

  if not set -q -g __fish_robbyrussell_functions_defined
    set -g __fish_robbyrussell_functions_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
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

  set -l arrow "$red➜ "
  set -l cwd $blue(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set -l git_branch $red(_git_branch_name)
    set git_info "$blue [git:$git_branch$blue]"

    if [ (_is_git_dirty) ]
      set -l dirty "$red ✗"
      set git_info "$git_info$dirty"
    end
  end

  if set -q -g VIRTUAL_ENV
     set -l ve_tag (basename "$VIRTUAL_ENV")
     set vex_info "$blue [env:$green$ve_tag$blue]"
     #echo -n (set_color green)"($ve_tag) "(set_color normal)
  end

  echo -n -s ' '$cwd $git_info $vex_info $normal ' ' $arrow
end
