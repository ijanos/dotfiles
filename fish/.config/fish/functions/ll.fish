function ll --description "List contents of directory using long format"
	#ls -lhXN --time-style=long-iso --group-directories-first $argv
	exa --long --group-directories-first $argv
end
