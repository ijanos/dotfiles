"" General settings
set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
set number                      " always show line numbers
set wildmenu                    " show possible matches for tabcompletion

" Exclude these files and directories from search
set wildignore+=*.git/*,*.hg/*,*.svn/*,*.so,*.pdf,*.py[co],*.o,*.swp

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

"" Vundle settings
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


filetype plugin indent on       " required!

"" Keymaps

map <F4> :nohl<CR>

" Disable shift-up/down which is pgup/pgdown
map <S-Up> k
map <S-Down> j

" Make tab in visual mode work like I think it should (keep highlighting)
vmap <tab> >gv
vmap <s-tab> <gv
