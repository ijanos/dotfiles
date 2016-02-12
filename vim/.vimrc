call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'endel/vim-github-colorscheme'
Plug 'kien/ctrlp.vim'
Plug 'dag/vim-fish'
Plug 'ntpeters/vim-better-whitespace'
autocmd BufWritePre * StripWhitespace
"-- https://github.com/ntpeters/vim-better-whitespace/issues/40
autocmd VimEnter * DisableWhitespace
autocmd VimEnter * EnableWhitespace
"--
Plug 'rust-lang/rust.vim'
call plug#end()

set smartcase
