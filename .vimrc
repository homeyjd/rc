" Eevee's vimrc
" Heavily modified by homeyjd with input from around the interwebs

" vim mode preferred!
set nocompatible

" set xterm title, and inform vim of screen/tmux's syntax for doing the same
set titlestring=vim\ %{expand(\"%t\")}
if &term =~ "^screen"
    " pretend this is xterm.  it probably is anyway, but if term is left as
    " `screen`, vim doesn't understand ctrl-arrow.
    if &term == "screen-256color"
        set term=xterm-256color
    else
        set term=xterm
    endif

    " gotta set these *last*, since `set term` resets everything
    set t_ts=k
    set t_fs=\
endif
set title

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
fixdel

" backups and other junky files
set nobackup                    " backups are annoying
set writebackup                 " temp backup during write
" TODO: backupdir?
if version >= 703
    set undodir=~/.vim/undo         " persistent undo storage
    set undofile                    " persistent undo on
endif

" user interface
set history=50                  " keep 50 lines of command line history
set laststatus=2                " always show status line
set lazyredraw                  " don't update screen inside macros, etc
set matchtime=2                 " ms to show the matching paren for showmatch
set number                      " line numbers
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set showmatch                   " show matching brackets while typing
"if version >= 703
"    set relativenumber              " line numbers spread out from 0
"endif
set cursorline                  " highlight current line

" regexes
set incsearch                   " do incremental searching
set ignorecase                  " useful more often than not
set smartcase                   " case-sens when capital letters

" whitespace
set tabstop=4                   " a tab is visualized as 4 spaces
set autoindent                  " keep indenting on <CR>
set shiftwidth=4                " one tab = four spaces (autoindent)
set softtabstop=4               " one tab = four spaces (tab key)
"set expandtab                   " never use hard tabs
set copyindent                  " copy indent from the above line
set fileformats=unix,dos        " unix linebreaks in new files please
set listchars=tab:‣‣,extends:»,precedes:«,nbsp:·,trail:·,eol:␊
                                " appearance of invisible characters
set formatoptions-=o            " Don't add comment prefix
set formatoptions-=r            " Don't add comment prefix

" wrapping
"set colorcolumn=+1              " highlight 81st column
set linebreak                   " break on what looks like boundaries
set showbreak=↳\                " shown at the start of a wrapped line
"set textwidth=80                " wrap after 80 columns


" gui stuff
set ttymouse=xterm2             " force mouse support for screen
set mouse=a                     " terminal mouse when possible
set guifont=DejaVu\ Sans\ Mono\ 9
                                " nice fixedwidth font

" unicode
set encoding=utf-8              " best default encoding
setglobal fileencoding=utf-8    " ...
set nobomb                      " do not write utf-8 BOM!
set fileencodings=ucs-bom,utf-8,iso-8859-1
                                " order to detect Unicodeyness

" tab completion
set wildmenu                    " show a menu of completions like zsh
set wildmode=full               " complete longest common prefix first
set wildignore+=.*.sw*,__pycache__,*.pyc
                                " ignore junk files

" miscellany
set autoread                    " reload changed files
set scrolloff=2                 " always have 2 lines of context on the screen
set foldmethod=indent           " auto-fold based on indentation.  (py-friendly)
set foldlevel=99

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Large files and other autocmd stuff
if has("autocmd")

    " Filetypes and indenting settings
    filetype plugin indent on

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " Large files are > 10M
    let g:LargeFile = 1024 * 1024 * 10
    "   eventignore+=FileType (no syntax highlighting etc)
    "   noswapfile (save copy of file)
    "   bufhidden=unload (save memory when other file is viewed)
    "   buftype=nowritefile (is read-only)
    "   undolevels=-1 (no undo possible)
    augroup LargeFile
        autocmd BufReadPre *
        \ let f=expand("<afile>") |
        \ if getfsize(f) > g:LargeFile |
        \   set eventignore+=FileType |
        \   setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
        \ else |
        \   set eventignore-=FileType |
        \ endif
    augroup END

    augroup Format-Options
        autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    augroup END

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
" Pathogen; load all bundles
if has("pathogen")
    filetype off  " uh, necessary
    call pathogen#runtime_append_all_bundles()
    call pathogen#helptags()
endif " has("pathogen")s

" SuperTab; use omni completion by default
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Python-mode; linting is kind of annoying, so tame it
let g:pymode_lint_checker = "pyflakes"
let g:pymode_lint_cwindow = 0

" Powerline; uses its own runtime stuff
set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim

" Ctrl-P settings
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](build|[.]git)$' }
let g:ctrlp_max_files = 50000   " i work on a project with a lot of files.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings
" Stuff that clobbers default bindings
" Force ^U and ^W in insert mode to start a new undo group
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Leader
let mapleader = ","
let g:mapleader = ","

" Swaps selection with buffer
vnoremap <C-X> <Esc>`.``gvP``P

" ctrl-arrow in normal mode to switch windows; overrides ctrl-left/right for
" moving by words, but i tend to use those only in insert mode
noremap <C-Left> <C-W><Left>
noremap <C-Right> <C-W><Right>
noremap <C-Up> <C-W><Up>
noremap <C-Down> <C-W><Down>

" -/= to navigate tabs
noremap - :tabprevious<CR>
noremap = :tabnext<CR>

" Map ^s to write current buffer
noremap <C-S> :w<CR>
vnoremap <C-S> <C-C>:Update<CR>
" ignore additional prompt after save in insert mode
inoremap <C-S> <C-O>:Update<CR><CR>

" Undo in insert mode
imap <c-z> <c-o>u

" Bind gb to toggle between the last two tabs
map gb :exe "tabn ".g:ltv<CR>
function! Setlasttabpagevisited()
    let g:ltv = tabpagenr()
endfunction

augroup localtl
au!
autocmd TabLeave * call Setlasttabpagevisited()
augroup END
autocmd VimEnter * let g:ltv = 1

""" For plugins
" gundo
noremap ,u :GundoToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and syntax
" in GUI or color console, enable coloring and search highlighting
if &t_Co > 2 || has("gui_running")
    syntax on
    set background=dark
    set hlsearch
endif

set t_Co=256  " force 256 colors
colorscheme molokai

if has("autocmd")
    " When editing a file, always jump to the last known cursor position.
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif " has("autocmd")

" trailing whitespace and column; must define AFTER colorscheme, setf, etc!
hi ColorColumn ctermbg=black guibg=darkgray
hi WhitespaceEOL ctermbg=red guibg=red
hi LineNr ctermfg=grey
match WhitespaceEOL /\s\+\%#\@<!$/


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last but not least, allow for local overrides
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
