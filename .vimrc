" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set nu           "show line number
set wmnu         "wildmenu, show possible commands/completes in the statusline
                 "when pressing tab in command mode
set wildignore+=*.log,*.pdf,*.swp,*.o,*.py[co],*~,*.hi
set tabstop=4    "1 tab is 4 spaces long
set sw=4
set smarttab
set expandtab
set softtabstop=4
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set hidden          " Hide buffers when they are abandoned
set nomore          " Don't pause on long messages
set ttyfast         " Indicates a fast terminal connection
set noerrorbells    " Error bells are annoying
set shortmess=aITtoO 

" Don't use Ex mode, use Q for formatting
map Q gq 

set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pdf


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  colorscheme desert
  set hlsearch
endif

set laststatus=2
if has("statusline")
	set statusline=%F%m%r%h%w\ [%{&ff}:%{(&fenc==\"\"?&enc:&fenc)}]%y\ %=%{fugitive#statusline()}[%l,%v][%L][%p%%]
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  match ErrorMsg '\%>79v.\+' "highlight lines longer than 80 characters
  
  " Python
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType python compiler pylint
     let g:pylint_onwrite = 0
     let g:pylint_show_rate = 0

  " Perl
  autocmd FileType perl compiler perl

  " Erlang
  autocmd FileType erlang compiler erlang
  let g:erlangCompiler="erlc"

  " Haskell
  au Bufenter *.hs compiler ghc "use ghc functionality for haskell files
  let g:haddock_browser = "arora"

  " Misc
  autocmd BufReadPre *.nfo set ft=nfo

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")


" keybinds

" I only press F1 when I miss my ESC key, the opening of the help windows is
" annoying. Maybe I should map it to <ESC>
nmap <F1> <nop> 
map <F6> :QFix<CR>

map <F5> :make<CR><CR>

" Make tab in v mode work like I think it should (keep highlighting):
vmap <tab> >gv
vmap <s-tab> <gv

" Select all.
map <c-a> ggVG

" Shift-up/down was pgup/pgdown which is annoying
map <S-Up> k
map <S-Down> j


" Up/down keys move one screen line and note a real line
map <Up> gk
map <Down> gj

" Change buffers easily
nmap <silent> <M-Left> :bp<CR>
nmap <silent> <M-Right> :bn<CR>

nmap <silent> <M-Up> :cp<CR>
nmap <silent> <M-Down> :cn<CR>

" Tlist
let Tlist_WinWidth = 40
map <F3> :Tlist<CR>

map <F4> :nohl<CR>
map <F10> :TMiniBufExplorer<CR>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

if !exists(":QFix")
    command -bang -nargs=? QFix call QFixToggle(<bang>0)
    function! QFixToggle(forced)
      if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
      else
        copen 10
        let g:qfix_win = bufnr("$")
      endif
    endfunction
endif
