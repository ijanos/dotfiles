call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'endel/vim-github-colorscheme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dag/vim-fish'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'matze/vim-move'
Plug 'ijanos/vim-keymaps'
call plug#end()

" follow but ignore looped internal symlinks to avoid duplicates
let g:ctrlp_follow_symlinks = 1

set smartcase
set number


vmap <A-Down> <Plug>MoveBlockDown
vmap <A-Up> <Plug>MoveBlockUp
nmap <A-Down> <Plug>MoveLineDown
nmap <A-Up> <Plug>MoveLineUp

" disable F1 help and map it to ESC
map <F1> <Esc>
imap <F1> <Esc>
