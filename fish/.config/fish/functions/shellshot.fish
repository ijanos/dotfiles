function shellshot --description "shell screenshot, pipe a command into it"
	convert -font "Fira-Code-Medium"  -pointsize 24 label:@- /tmp/shellshot.png
end
