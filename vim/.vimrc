call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'endel/vim-github-colorscheme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dag/vim-fish'
Plug 'bronson/vim-trailing-whitespace'
Plug 'rust-lang/rust.vim'
call plug#end()

set smartcase
set number

" ignore files in .gitignore when using CTRL-P
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
