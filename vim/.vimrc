"""""""""""""""""""
"" General settings
"""""""""""""""""""
set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
set number                      " always show line numbers
set wildmenu                    " show possible matches for tabcompletion
set hidden                      " allow modified buffers to stay in the background
set laststatus=2                " always show statusbar line

" Exclude these files and directories from search
set wildignore+=*.git/*,*.hg/*,*.svn/*,*.so,*.pdf,*.py[co],*.o,*.swp,*.aux,*.toc

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is four spaces
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter


set shell=/usr/bin/dash

""""""""""""""""""
"" Vundle settings
""""""""""""""""""
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
" don’t manage working directory
let g:ctrlp_working_path_mode = 0

" Zenburn colorscheme
Plugin 'Zenburn'

Plugin 'endel/vim-github-colorscheme'

" Syntax checking
Plugin 'scrooloose/syntastic'
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_go_checkers = ['go', 'golint', 'govet']

" Surround plugin
Plugin 'tpope/vim-surround'

" TypeScript syntax
Plugin 'leafgarland/typescript-vim'

" Golang autocomplete
Plugin 'nsf/gocode', {'rtp': 'vim/'}

Plugin 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1

call vundle#end()
filetype plugin indent on       " required!

""""""""""
"" Settings
""""""""""

" Disable smartindent for LaTeX documents
au BufEnter *.tex set nosmartindent

" Auto format golang on save
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Recognize .md as markdown, not modula2
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Highlight trailing whitespace
match Todo /\s\+$/

" Show tab characters
set list lcs=tab:→ 


""""""""""
"" Keymaps
""""""""""

" Select all
map <C-a> ggVG

map <F4> :nohl<CR>

" Disable shift-up/down which is pgup/pgdown
map <S-Up> k
map <S-Down> j

" Natural behavior for cursor keys (1 keypress == 1 screen line)
map <Up> gk
map <Down> gj

" Move selected lines up/down, something like: http://vimcasts.org/episodes/bubbling-text/
vmap <C-S-Down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-S-Up> :m'<-2<cr>`>my`<mzgv`yo`z

" Make tab in visual mode work like I think it should (keep highlighting)
vmap <tab> >gv
vmap <s-tab> <gv

" Toggle the location window
map <F6> :lopen<CR>
map <S-F6> :lclose<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Make F1 act as escape so you don't have to worry about mistyping
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Easier buffer switching
map <C-PageUp> :bp<CR>
map <C-PageDown> :bn<CR>

map <C-Tab> :bn<CR>
map <C-S-Tab> :bp<CR>