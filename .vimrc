" ==================================================
" Basics.
" ==================================================
" syntax, utf-8, ft, nocompatible, autoreload
filetype plugin on
filetype indent on
set nocompatible          " leave the old ways behind
set encoding=utf-8 nobomb " UTF-8 encoding for all new files
set clipboard+=unnamed    " yank and copy to the OS clipboard
set shortmess=atI

if &t_Co > 2 || has("gui_running")
  set t_Co=256            " 256 colors please
  syntax on 
  set hlsearch            " highlighted search
endif


" ==================================================
" On Windows...
" ==================================================
if has("gui_win32")
	" ... do nonsense.

  " Stupid hack to prevent Win7-gvim window unsapping when vimrc autoreloads
	let myguifont="Consolas:h12"

	if (&guifont != myguifont)
		execute "set guifont=".myguifont 
	endif
	
	" gvim gui
	set guioptions=aceg  " http://vimdoc.sourceforge.net/htmldoc/options.html#%27guioptions%27
	set guioptions-=m " menubar
	set guioptions-=r " scrollbar
	set guioptions-=Tt " toolbar

	" Autoreload gvimrc.
  if has("autocmd") " https://github.com/paranoida/vimrc/plugins.vim
    au BufWritePost *vimrc source $MYGVIMRC
  endif

  set noswapfile  " no swapfiles on windows

	" pathogen with $VIM/vimfiles/bundle path
	call pathogen#infect($VIM.'\vimfiles\bundle\{}')

" ==================================================
" Not on Windows...
" ==================================================
else
	" ... we're not on windows, so just be normal.

	call pathogen#infect('~/.vim/bundle/{}')

  	" Autoreload vimrc.
  if has("autocmd") " https://github.com/paranoida/vimrc/plugins.vim
    au BufWritePost *vimrc source $MYVIMRC
  endif

  
  set directory=~/tmp " put swapfiles in /tmp instead of current directory.
  set backupdir=~/.vim/backups
  if exists("&undodir")
    set undodir=~/.vim/undo
  endif
endif


" ==================================================
" Colorscheme.
" ==================================================
if has("gui_running")
  colorscheme ir_black
else
  "if exists('$WINDOWID') && &term =~ "rxvt"
    colorscheme miromiro
  "else
  "  colorscheme miro8       " colourscheme for the 8 colour linux term
  "endif
endif

	
" ==================================================
" Files
" ==================================================
set nobackup    " disable backup files (filename~)
"set noswapfile
"set modeline    " disabled to use securemodelines plugin
"set modelines=5
"set exrc secure " Enable per-directory .vimrc files and disable unsafe commands in them
"set binary noeol  " Don’t add empty newlines at the end of files 

" ==================================================
" User Interaction (Keys, Mouse)
" ==================================================
let mapleader="\\"
set timeout timeoutlen=5000 ttimeoutlen=5000
set backspace=2 " full backspacing capabilities (indent,eol,start)
set mouse=a " enable mouse in all modes
set mousehide     " Hide the mouse when typing text
set nostartofline


" ==================================================
" GUI
" ==================================================

set cursorline            " track position
set scrolloff=15          " keep x lines of context
set ttyfast

set noerrorbells          " no beeps on errors
set visualbell            " show visual bell

set title                 " show title in console title bar
set noruler               " no: display row, column and % of document
set showmatch             " show matching () {} etc.
set wildmenu              " enhanced tab-completion shows all matching cmds in a popup menu
set splitright splitbelow " place new splits right then below

" ==================================================
" Folding.
" ==================================================
set foldmethod=indent
set foldnestmax=4     " deepest fold level
set nofoldenable      " start without folds
" set foldcolumn=1
" set foldlevel=0


" ==================================================
" Line numbers.
" ==================================================
set number                " show linenumbers by default

if exists("&relativenumber")
  au InsertEnter * set norelativenumber number
  au InsertLeave * set relativenumber number
endif

" ==================================================
" Code format & Indenting.
" ==================================================
set autoindent            " auto indents next new line
set nosmartindent
set nocindent
set expandtab         " expand tabs with spaces
set tabstop=2         " <Tab> move three characters
set shiftwidth=2      " >> and << shift 3 spaces
set softtabstop=2     " see spaces as tabs
set nowrap                " don't wrap lines
" set textwidth=79            " hard wrap at 79 characters

" ==================================================
" Searching.
" ==================================================
set hlsearch " highlight all search results
set incsearch " increment search
set ignorecase " case-insensitive search
set smartcase " uppercase causes case-sensitive search

" ==================================================
" Status bar.
" ==================================================
set cmdheight=1
set showcmd               " show partial commands in the status line
set showmode              " show current mode
set laststatus=2 " turns status line always on and configures it
set statusline=%<%f\ %m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P\ of\ %L


set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

if has("autocmd")
  " Restore cursor position
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

  " Filetypes (au = autocmd)
  " https://github.com/patoroco/system-config/blob/master/.vimrc
  au FileType helpfile set nonumber " no line numbers when viewing help
  au FileType mail,tex set textwidth=72
  au FileType cpp,c,java,sh,pl,php,asp set autoindent
  au FileType cpp,c,java,sh,pl,php,asp set smartindent
  au FileType cpp,c,java,sh,pl,php,asp set cindent
  au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
	au BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif


" ==================================================
" Load keybinds.
" ==================================================
so ~/.vim/_keys.vim

" vim: ts=2:sw=2:tw=80:et :
