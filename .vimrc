"
" ~/.vimrc
"
"{{{1 Plugins
set nocompatible          " leave the old ways behind
if has('win32')
  execute pathogen#infect('~/vimfiles/pathogens/{}')
  call plug#begin('~/vimfiles/plugged')
else
  execute pathogen#infect('pathogens/{}')
  call plug#begin()
endif


" Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/visualrepeat'
Plug 'junegunn/vim-easy-align'

" Plug 'godlygeek/tabular'
Plug 'ciaranm/securemodelines'
Plug 'tpope/vim-eunuch'  " :SudoWrite / :Wall
Plug 'itchyny/lightline.vim'
Plug 'jamessan/vim-gnupg'
Plug 'rking/ag.vim'

" Autocompleting
" Plug 'jiangmiao/auto-pairs'
" Plug 'mattn/emmet-vim',
Plug 'nishigori/increment-activator'

" Syntax etc
Plug 'scrooloose/syntastic',
Plug 'sheerun/vim-polyglot',
Plug 'git://fedorapeople.org/home/fedora/wwoods/public_git/vim-scripts.git', {}
Plug 'plasticboy/vim-markdown',
Plug 'guyhughes/vim-ini-fold',
" Plug 'vim-scripts/SQLUtilities',
" Plug 'PotatoesMaster/i3-vim-syntax'

" Git/VCS
Plug 'airblade/vim-gitgutter',
Plug 'tpope/vim-fugitive',
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'

" Colour
Plug 'w0ng/vim-hybrid',
Plug 'guns/jellyx.vim',
Plug 'fisadev/fisa-vim-colorscheme',
Plug 'altercation/vim-colors-solarized'
Plug 'whatyouhide/vim-gotham'
" Plug 'chriskempson/base16-vim'

call plug#end()

if has('autocmd')
  autocmd!
endif
" }}}1
"{{{1 Standard (syntax, utf8, ft, clipboard, 256 )
filetype plugin on
filetype indent on

set encoding=utf-8 nobomb  " UTF-8 encoding for all new files
set shortmess=aoOstTAI     " shorten all messages except written
set ttymouse=xterm2        " More accurate mouse tracking
set ttyfast                " More redrawing characters sent to terminal
set timeoutlen=900
set ttimeoutlen=0
set report=0               " Always report the number of lines changed by a cmd

if &t_Co > 2 || has("gui_running" )
  set t_Co=256 " 256 colors please
  syntax on
  set nohlsearch " highlighted search
  " let base16colorspace=256
endif
"}}}
"{{{1 Undo & Cache
if !isdirectory(expand('~/.cache/vim/undo'))
  if !isdirectory(expand('~/.cache/vim'))
    if !isdirectory(expand('~/.cache'))
      call mkdir(expand('~/.cache'), 'p', 0700)
    endif
    call mkdir(expand('~/.cache/vim'), 'p', 0700)
  endif
  call mkdir(expand('~/.cache/vim/undo'), 'p', 0700)
endif
if isdirectory(expand('~/.cache/vim/undo'))
  set directory=~/.cache/vim
  set viminfo+=n~/.cache/vim/viminfo
  let g:netrw_home = expand('~/.cache/vim')
  if has('persistent_undo')
    set undofile
    set undodir=~/.cache/vim/undo
  endif
endif
set undolevels=2000

"{{{1 OS & GUI Settings

"{{{2 Windows... pitiful...
if has("gui_win32") " returns 1 on WOW64  =>[OS-Settings]
  " ... do nonsense.

  if has('gui_running')
    set guicursor+=a:blinkon0 " disable blinking cursor (gvimwin32)
    let &guifont="Consolas:h10"
  endif

"{{{2 Not Windows... Lucky you!
else
  " ... we're not on windows, so just be normal.
  if has('gui_running')
    let &guifont="Monaco\ 11"
  endif

  if has('xterm-clipboard')
    set clipboard=unnamedplus    " yank and copy to the X11 PRIMARY clipboard (selection)
    "http://vim.wikia.com/wiki/Accessing_the_system_clipboard
  else
    set clipboard=unnamed
  endif
endif  " [/OS-Settings]<=
"  }}}
"{{{2 GUI
if has('gui_running')
  " [+c text dialogues instead of popups]
  " http://vimdoc.sourceforge.net/htmldoc/options.html#%27guioptions%27
  set go=aceg

  " menubar
  set guioptions-=m

  " scrollbar
  set guioptions-=r

  " toolbar
  set go-=Tt

"{{{2 Terminal: emenus
else
    source $VIMRUNTIME/menu.vim
    map <Leader>em :emenu <C-Z>
endif


"{{{1 Plugin Configuration

"  NERDTree
let g:NERDTreeBookmarksFile = expand('~/.cache/vim/NERDTreeBookmarks')
let g:NERDChristmasTree = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeSortOrder = []
let g:NERDTreeHijackNetrw = 0

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDMenuMode = 0

" INDENTLINE
let g:indentLine_color_term = 233
let g:indentLine_color_gui = '#121212'
let g:indentLine_char = '|'

" Increment Activator
let g:increment_activator_no_default_key_mappings = 1
let g:increment_activator_filetype_candidates =
      \ {
      \ '_': [
      \   [
      \     's:black', 's:red', 's:green', 's:yellow', 's:blue', 's:magenta',
      \     's:cyan', 's:white', 's:blackb', 's:redb', 's:greenb', 's:yellowb',
      \     's:blueb', 's:magentab', 's:cyanb', 's:whiteb'
      \   ],
      \   [
      \     'black', 'red', 'green', 'yellow', 'blue', 'magenta',
      \     'cyan', 'white', 'blackb', 'redb', 'greenb', 'yellowb',
      \     'blueb', 'magentab', 'cyanb', 'whiteb'
      \   ],
      \ ],
      \ 'gitrebase': [
      \   [
      \      'pick','reword','edit','squash','fixup','exec'
      \   ],
      \ ],
    \ }
" s: black  no
"{{{ Lightline.vim
if has("autocmd")
  " let g:lightline = { 'colorscheme': 'wombat' }
  let g:lightline = { 'colorscheme': 'euphramiro' }
  let g:lightline.mode_map = {
        \ 'n' : '',
        \ 'i' : 'INSERT',
        \ 'R' : 'REPLACE',
        \ 'v' : 'VISUAL',
        \ 'V' : 'V-LINE',
        \ 'c' : 'COMMAND',
        \ "\<C-v>": 'V-BLOCK',
        \ 's' : 'SELECT',
        \ 'S' : 'S-LINE',
        \ "\<C-s>": 'S-BLOCK',
        \ '?': '      ' }
		let g:lightline.tabline = {
		    \ 'left': [ [ 'tabs' ] ],
		    \ 'right': [ ] }
   		let g:lightline.active = {
		    \ 'left': [ [ 'mode', 'paste' ],
		    \           [ 'readonly', 'filename', 'modified' ] ],
		    \ 'right': [ [ 'lineinfo' ],
		    \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
    let g:lightline.inactive = {
		    \ 'left': [ [ 'filename' ] ],
		    \ 'right': [ [ 'lineinfo' ],
        \ ] }
  endif
"}}}


" }}}
"{{{1 Code format & Indenting
set noautoindent     " auto indents next new line
set nosmartindent
set nocindent
set expandtab        " expand <Tabss with spaces
set shiftround       " always round indents to multiples of shiftwidth
set tabstop=2        " <Tab> move three characters
set shiftwidth=2     " >> and << shift 3 spaces
set softtabstop=2    " see spaces as tabs

set showcmd      " show typing in normal mode
set showbreak=…\  " show x in front of wrapped lines (trailing escaped space `\ `)
set textwidth=0  " disable hard wrap (e.g. set to 79 for new files)

set formatoptions=q  " Format text with gq, but don't format as I type.
set formatoptions+=n " gq recognizes numbered lists, and will try to
set formatoptions+=1 " break before, not after, a 1 letter word
set nowrap
set linebreak        " wrap long lines at a character in &breakat'


" }}}
"{{{1 Interaction (Keys, Mouse).

let mapleader="\<Space>"
set backspace=indent  " =0: full backspacing capabilities (indent,eol,start)
set nojoinspaces  " never joing lines with two spaces

"set mouse=nv " enable mouse in normal, visual
set mouse=a       " akk
set mousehide     " Hide the mouse when typing text
set nostartofline " Avoid moving cursor to BOL when jumping around

set whichwrap=b,s,h,l,<,> " <BS> <Space> h l <Left> <Right> can change lines
set virtualedit+=block    " Let cursor move past the last char in <C-v> mode
set scrolloff=3           " Keep 3 context lines above and below the cursor

set matchpairs=(:),{:},[:],<:>
set noshowmatch  " Don't Briefly jump to a paren once it's balanced
set matchtime=2  " (for only .2 seconds).

set complete=.,w,b,u,t " Better Completion TODO: g.
set completeopt=longest,menuone,preview

" This breaks arrow keys etc.
" http://stackoverflow.com/questions/22425596/trigger-cursor-positioning-and-selection-on-going-to-normal-mode-or-esc-map/22677880#22677880
" set noesckeys     " Don't check if Escape is used for Meta entry


if has("autocmd")
  " Resize splits with window
  au VimResized * :wincmd =

  " automatically leave insert mode after 'updatetime' ms of inacction
  " http://vim.wikia.com/wiki/To_switch_back_to_normal_mode_automatically_after_inaction
  au CursorHoldI * stopinsert
  au InsertEnter * let updaterestore=&updatetime | set updatetime=2000
  au InsertLeave * let &updatetime=updaterestore

  " Restore cursor position
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

  " Autoreload vimrc.
  augroup reload_vimrc " {
    au!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
  augroup END " }
endif

" }}}
"{{{1 Visuals.

"{{{2 Basic

set number
set synmaxcol=1300 " Avoids editor lockup on extremely long lines
set laststatus=2  " ??
set cursorline    " track position
set noshowmode    " hide secondary statusline
set noerrorbells  " no beeps on errors
set visualbell    " show visual bell
set title         " show title in console title bar
set noruler       " no: display row, column and % of document
set splitright    " place new splits right & below
set splitbelow

"{{{2 Cursor Column
augroup activecursor
  autocmd!
  autocmd WinEnter * set cursorcolumn   | set cursorline
  autocmd WinLeave * set nocursorcolumn | set nocursorline
augroup END

"{{{2 Commandline & Wildmenu
set history=1000

if has('wildmenu')
 " enhanced tab-completion shows all matching cmds in a popup menu
 set wildmenu
 set wildmode=full
 set wildcharm=<C-Z>

 " don't complete files I won't edit with vim
 if has('wildignore')
   set wildignore+=*.a,*.o
   set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png
   set wildignore+=.DS_Store,.git,.hg,.svn
   set wildignore+=*~,*.swp,*.tmp
 endif

" Complete files without case sensitivity, if the option is available
  if exists('&wildignorecase')
    set wildignorecase
  endif
endif
"}}}
"{{{ Listchars: show spaces, tab, eol trailing
set listchars=trail:·,precedes:⇐,extends:⇒,tab:▸\ ,eol:↲
set fillchars=fold:\ ,diff:╳,vert:│
set nolist
"}}}
"{{{ Colorscheme.

if has("win32")
  colorscheme ir_black
elseif has("gui_running")
  let g:jellyx_show_whitespace = 0
  colorscheme jellyx
  "colorscheme mirodark
  "colorscheme atom
else
  colorscheme mirodark
  "colorscheme ir_black
  " colorscheme gotham
  " colorscheme hybrid
  " colorscheme base16-ashes
endif

"}}}
"{{{ Folding.
fu! CustomFoldText() "{{{
  " I am from http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/

  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let lineCount = line("$")
  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf "}}}
set foldtext=CustomFoldText()
set foldmethod=marker
set foldlevelstart=99
"set foldnestmax=4     " deepest fold level
"set foldenable      " start without folds
"set foldcolumn=1
"setlocal foldlevel=0
"}}}
"{{{ Searching.

set incsearch  " increment search
set ignorecase " case-insensitive search
set smartcase  " uppercase causes case-sensitive search
"set hlsearch  " included with colours -- highlight search results
set nogdefault " Disabled - See http://j.mp/1mZvnrt  (no `g` on `:s`)
"}}}

"{{{ Files.

"{{{ Keep old backups, write new ones.
set nobackup     " Disabled - See above (OS Settings)
set writebackup  "
"}}}

"{{{ Disabled - Superseeded by other functionality.
" set noswapfile   " Disabled - See above (OS Settings)
" set exrc secure  " Disabled -  Per-directory .vimrc files without unsafe cmds
" set binary noeol " Disabled - Don’t add empty newlines at the end of files
set nomodeline     " Disabled - Using securemodelines plugin
" set modelines=5

" }}}

set noautowrite      " Never write a file unless I request it.
set noautowriteall   " NEVER.
"set noautoread      " Don't automatically re-read changed files.
set ffs=unix,dos,mac " Try recognizing dos, unix, and mac line endings.


"{{{ Filetype misc.
if has("autocmd")

  " Filetypes (au = autocmd)
  au FileType helpfile setlocal nonumber " no line numbers when viewing help
  au FileType mail,tex setlocal textwidth=72
  au FileType cpp,c,java,sh,pl,php,asp setlocal autoindent
  au FileType c,cpp,java setlocal foldmethod=syntax foldnestmax=5
  au FileType cpp,c,java,sh,pl,php,asp setlocal cindent
  au BufNewFile,BufRead  modprobe.conf setlocal syntax=modconf
  "au BufNewFile,BufRead *.json setfiletype json syntax=javascript

  "https://github.com/patoroco/system-config/blob/master/.vimrc

endif
" }}}

" }}}

"{{{1 Keybindings.
"{{{2 Basic functionality extension
vnoremap > >gv
vnoremap < <gv

" Center the cursor on the search word when using 'n'
" http://git.z3bra.org/cgit.cgi/dotfiles/tree/vimrc
nmap n nzz
nmap N Nzz

""" <C-f> BREAKS IN GVIM -- wontfix -- plus i like q:
" I use <C-f> for commandline window
" nnoremap q: <Nop>
" nnoremap q? <Nop>
" nnoremap q/ <Nop>

nnoremap <buffer> <Left> <Nop>
nnoremap <buffer> <Right> <Nop>
nnoremap <buffer> <Up> <Nop>
nnoremap <buffer> <Down> <Nop>

inoremap <buffer> <Left> <Esc>
inoremap <buffer> <Right> <Esc>
inoremap <buffer> <Up> <Esc>
inoremap <buffer> <Down> <Esc>

vnoremap <buffer> <Left> <Nop>
vnoremap <buffer> <Right> <Nop>
vnoremap <buffer> <Up> <Nop>
vnoremap <buffer> <Down> <Nop>

"{{{2 splits, tmux aware.
" pieced together from:
" https://github.com/christoomey/vim-tmux-navigator
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits
if exists('$TMUX')
  let g:tmux_is_last_pane = 0
  au WinEnter * let g:tmux_is_last_pane = 0
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  function! TmuxOrSplitPrevious()
    let nr = winnr()
    if !g:tmux_is_last_pane
      silent! execute 'wincmd p'
    endif
    if g:tmux_is_last_pane || nr == winnr()
      silent call system('tmux select-pane -l')
      let g:tmux_is_last_pane = 1
    else
      let g:tmux_is_last_pane = 0
    endif
  endfunction

  " let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  " let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  " let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
  nnoremap <silent> <C-\> :call TmuxOrSplitPrevious()<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif
" insert mode <C-k> inserts digraphs etc
inoremap <C-k> <C-k>
"}}}
"{{{2 Timestamps, datestamps

if exists("*strftime")
  " Local datestamp
  noremap <silent> <leader>zl m'A<C-R>=strftime("%d.%m.%Y")<CR><ESC>``

  if has('win_32')
    " To hell with it... local weak datestamps for Windows
    " Unless for some unholy reason there's no strftime compiled in vim
    " ... then the environment is garbage, so who cares about timestamps.
    map <silent> <leader>zs <leader>zl
    map <silent> <leader>zd <leader>zl
  else
    " Real timestamps, yes. Praise GNU... and Darwin?
    noremap <silent> <Leader>zs m'A<C-R>=system('date -u \+\%Y\%m\%dT\%H\%MZ')<CR><ESC>``
    noremap <silent> <Leader>zd m'A<C-R>=system('date -u \+\%Y\%m\%dZ')<CR><ESC>``
  endif
endif
noremap <silent> <Leader>gh a<C-R>=' Guy Hughes'<CR><ESC>

" Timestamped signatures
nmap <silent> <leader>zh A<C-R>=' [Guy Hughes // '<CR><ESC><leader>zs<ESC>A<C-R>=']'<CR><ESC>
nmap <silent> <Leader>zz A<C-R>=' ['.expand("$USER").' // '<CR><ESC><leader>zs<ESC>A<C-R>=']'<CR><ESC>
"}}}2
"{{{2 Leader.

" Edit vimrc.
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>

" In normal/insert mode, ac center aligns the text after it to &tw or 80 chars
nnoremap <leader>ac :center<CR>
"
" <Leader>dd to black hole register
nmap <silent> <leader>dd "_dd
vmap <silent> <leader>d "_d
nmap <silent> <leader>x "_x

" Increment activator
nmap <Leader>aa <Plug>(increment-activator-increment)
nmap <Leader>az <Plug>(increment-activator-decrement)

" <leader>\ clear hlsearch and redraw screen.
noremap <silent> <Leader><Leader> :nohls<cr><c-l><CR>

"{{{ <Leader>ml - Append Modeline.
" https://github.com/godlygeek/vim-files/blob/master/.vimrc#L346
" Insert a modeline on the last line with <leader>ml
nnoremap <Leader>ml :call ModelineStub()<CR>
"}}}

" Remove trailing spaces from lines
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
nnoremap <Leader>dts :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Toggles
nnoremap <silent> <Leader>n :set invnumber<CR>
nnoremap <silent> <Leader>sp :set spell!<cr>
nnoremap <silent> <Leader>p :set invpaste<CR>
nnoremap <silent> <Leader>w :set invwrap<CR>
nnoremap <silent> <leader>l :setlocal list!<CR>

" Q formats paragraphs, instead of entering ex mode
noremap Q gq
nnoremap <silent> gqJ :call Exe#ExeWithOpts('norm! gqj', { 'tw' : 2147483647 })<CR>

" K should behave like J
nnoremap K kJ


"{{{2 Plugin: Easy Align
" Disable ignore comments/strings by default, change with CTRL-G
" let g:easy_align_ignore_groups=[]

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


