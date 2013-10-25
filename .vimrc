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

" Exclude these files and directories from search
set wildignore+=*.git/*,*.hg/*,*.svn/*,*.so,*.pdf,*.py[co],*.o,*.swp,*.aux,*.toc


" Only redraw when necessary to avoid flicker
set lazyredraw

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

""""""""""""""""""
"" Vundle settings
""""""""""""""""""
filetype off                    " required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

" UI additions
Bundle 'minibufexplorerpp'
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1

Bundle 'kien/ctrlp.vim'
" don’t manage working directory
let g:ctrlp_working_path_mode = 0

" Zenburn colorscheme
Bundle 'Zenburn'

" Syntax checking
Bundle 'scrooloose/syntastic'
let g:syntastic_python_checker = 'flake8'

" Surround plugin
Bundle 'tpope/vim-surround'

" TypeScript syntax
Bundle 'leafgarland/typescript-vim'

" Golang autocomplete
Bundle 'nsf/gocode', {'rtp': 'vim/'}



filetype plugin indent on       " required!

""""""""""
"" Settings
""""""""""

" Disable smartindent for LaTeX documents
au BufEnter *.tex set nosmartindent

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
