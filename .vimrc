" ==============================
" Vim Configuration File (.vimrc)
" ==============================

let mapleader = " "      " Set leader key to Space

let s:vim_plug_path = expand('~/.vim/autoload/plug.vim')
let s:install_plugins = empty(glob(s:vim_plug_path))

if s:install_plugins
    if executable('curl')
        silent execute '!curl -fLo ' . shellescape(s:vim_plug_path) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    else
        echohl WarningMsg
        echom 'curl is required to install vim-plug automatically'
        echohl None
    endif
endif

if !empty(glob(s:vim_plug_path))
    call plug#begin()

    " List your plugins here
    Plug 'lervag/vimtex', { 'tag': 'v2.15' }
    Plug 'ojroques/vim-oscyank', { 'branch': 'main' }

    call plug#end()

    for s:plugin in values(g:plugs)
        if !isdirectory(s:plugin.dir)
            let s:install_plugins = 1
            break
        endif
    endfor

    if s:install_plugins
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

let g:vimtex_view_method = 'skim'

" ------------------------------
" Syntax Highlighting
" ------------------------------

filetype plugin indent on

if has("syntax")
    syntax on
endif

" ------------------------------
" UI / Display
" ------------------------------
set number               " Show line numbers
set cursorline           " Highlight the current line
set cursorcolumn         " Highlight the current column

" Status Line settings
set laststatus=2
set statusline=%f\ %y\ [%{&ff}]\ [%l/%L]
" %f = filename
" %y = file type
" &ff = file format (unix/dos/etc)
" %l/%L = current line / total lines

" Line Wrapping
set wrap                 " Enable line wrapping
set linebreak            " Break lines at word boundaries
set showbreak=↪          " Symbol for wrapped lines

" ------------------------------
" Indentation
" ------------------------------
set autoindent           " Enable automatic indentation
set shiftwidth=4         " Indent/outdent by 4 spaces with << and >>
set tabstop=4            " Set Tab width to 4 spaces
set softtabstop=4        " Backspace/delete removes 4 spaces
set expandtab            " Convert tabs to spaces
set backspace=indent,eol,start
" set smartindent        " Smart auto-indentation (C/C++ style)

" ------------------------------
" Encoding
" ------------------------------
set encoding=utf-8       " Internal string encoding UTF-8
set fileencoding=utf-8   " File saving encoding UTF-8

" ------------------------------
" Search
" ------------------------------
set ignorecase           " Case-insensitive search
set smartcase            " Case-sensitive if uppercase letters are used
set incsearch            " Show search matches while typing
set hlsearch             " Highlight search results
nnoremap <leader>/ :nohlsearch<CR>
" Press <leader>/ to clear search highlight
" <CR> = Execute command (Enter key)

" ------------------------------
" Clipboard
" ------------------------------
if has("clipboard")
    set clipboard=unnamed,unnamedplus
endif
" unnamed = "* register linked to OS clipboard
" unnamedplus = "+ register linked to OS clipboard
" Only set when Vim was built with clipboard support

nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>y_
vmap <leader>y <Plug>OSCYankVisual

" ------------------------------
" Disable Arrow Keys
" ------------------------------
" Normal mode
nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
nnoremap <Left>  <Nop>
nnoremap <Right> <Nop>

" Insert mode
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>

" Visual mode
vnoremap <Up>    <Nop>
vnoremap <Down>  <Nop>
vnoremap <Left>  <Nop>
vnoremap <Right> <Nop>

" ------------------------------
" Backup & Undo
" ------------------------------
" set nobackup             " Disable backup files (.bak)
" set nowritebackup        " Disable backup before overwriting
" set noswapfile           " Disable swap files (.swp)

" ------------------------------
" Insert-mode Escape Shortcuts
" ------------------------------
inoremap jj <Esc>        " Type 'jj' in insert mode to exit to normal mode
inoremap jk <Esc>        " Type 'jk' in insert mode to exit to normal mode
