# conf.d/homebrew.fish
for bindir in /usr/local/bin /opt/homebrew/bin /opt/homebrew/opt/curl/bin
    test -d $bindir && fish_add_path -p $bindir
end
type -q brew && eval (brew shellenv)
