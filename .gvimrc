" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" You can also specify a different font, overriding the default font
if has('gui_gtk2')
  "set guifont=Bitstream\ Vera\ Sans\ Mono\ 8
  set guifont=Inconsolata\ 10
else
  set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
endif

"colorscheme desert  
colorscheme zenburn

set guioptions-=T   "remove the toolbar
set guioptions-=m   "remove the menubar
set cul             "cursorline, eyecandy but useful (and resource hungry) 
set lz              "lazy redraw. so cursorline wont kill my slow machine
