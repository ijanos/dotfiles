function llr --description "List recent files and directories using long format"
	ls -lhtrN --time-style=long-iso $argv
end
