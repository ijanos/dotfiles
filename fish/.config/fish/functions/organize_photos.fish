function organize_photos --description "Oragnize photos into directories based on EXIF date"
	jhead -n%Y-%m-%d/%Y%m%d_%H%M%S $argv
end
