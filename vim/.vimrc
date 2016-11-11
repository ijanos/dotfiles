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
call plug#end()

" follow but ignore looped internal symlinks to avoid duplicates
let g:ctrlp_follow_symlinks = 1

set smartcase
set number

" move cursor by display lines when wrapping
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" disable shift-up/down
" I never press these intentionally
noremap <S-Up> <NOP>
noremap <S-Down> <NOP>

vmap <A-Down> <Plug>MoveBlockDown
vmap <A-Up> <Plug>MoveBlockUp
nmap <A-Down> <Plug>MoveLineDown
nmap <A-Up> <Plug>MoveLineUp

" disable F1 help and map it to ESC
map <F1> <Esc>
imap <F1> <Esc>
