function upall --description "update system"
	yay -Syu
	flatpak update
	rustup update
end
