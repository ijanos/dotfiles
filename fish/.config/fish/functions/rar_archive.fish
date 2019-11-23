function rar_archive
	rar a $argv -rr10% -htb -m0 -ma5 -qo+ -r -agYYYY-MM-DD-HH-MM
	# -rr10% recovery 10%
	# -htb blake2 hash
	# -m0 store only, no compression
	# -ma0 rar5
	# -qo+ quick open
	# -r recursive
	# -ag add date
end
