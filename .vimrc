"
" ~/.vimrc
"

" Vundle setup
" see :h vundle for more details or wiki for FAQ
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'editorconfig/editorconfig'
Plugin 'ciaranm/securemodelines'
Plugin 'tpope/vim-eunuch', {'name': 'eunuch'} " :SudoWrite / :Wall
Plugin 'gcmt/wildfire.vim' " Enter-select

" Autocompleting
Plugin 'jiangmiao/auto-pairs'
Plugin 'mattn/emmet-vim', {'name': 'auto-emmet'}

" Syntax etc
Plugin 'scrooloose/syntastic', {'name': 'syntax-syntastic'}
Plugin 'sheerun/vim-polyglot', {'name': 'syntax-polyglot'}
Plugin 'git://fedorapeople.org/home/fedora/wwoods/public_git/vim-scripts.git', {'name': 'syntax-systemd'}
Plugin 'plasticboy/vim-markdown', {'name': 'syntax-markdown'}

" Git/VCS
Plugin 'airblade/vim-gitgutter', {'name': 'git-gutter'}
Plugin 'tpope/vim-fugitive', {'name': 'git-fugitive'}

" Colour
Plugin 'w0ng/vim-hybrid', {'name': 'colour-w0ng-hybrid'}
Plugin 'guns/jellyx.vim', {'name': 'colour-guns-jellyx'}
Plugin 'fisadev/fisa-vim-colorscheme', {'name': 'colour-fisa'}


call vundle#end()          
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"

if has('autocmd')
  autocmd!
endif

" Standard. (syntax, utf8, ft, nocompatible, clipboard, 256 ) "{{{1
filetype plugin on
filetype indent on
set nocompatible          " leave the old ways behind
set encoding=utf-8 nobomb " UTF-8 encoding for all new files
set shortmess=aoOstTAI    " shorten all messages except written
set ttymouse=xterm2       " More accurate mouse tracking
set ttyfast               " More redrawing characters sent to terminal
" set notimeout ttimeout  " Wait for mappings, timeout on keycodes
set timeout ttimeout
"set timeoutlen=1000
"set ttimeoutlen=1000


if &t_Co > 2 || has("gui_running" )
  set t_Co=256 " 256 colors please
  syntax on
  set hlsearch " highlighted search
endif
"}}}

" TEMPORARY FILES {{{1
if !isdirectory(expand('~/.cache/vim/undo'))
  call mkdir(expand('~/.cache/vim/undo'), 'p', 0700)
endif
if isdirectory(expand('~/.cache/vim'))
  set directory=~/.cache/vim
  set viminfo+=n~/.cache/vim/viminfo
  let g:netrw_home = expand('~/.cache/vim')
endif
if has('persistent_undo') && isdirectory(expand('~/.cache/vim/undo'))
  set undofile
  set undodir=~/.cache/vim/undo
endif

"  OS Settings  {{{1

" Windows... pitiful... "{{{2
if has("gui_win32") " returns 1 on WOW64  =>[OS-Settings]
  " ... do nonsense.

  if has('gui_running')
    let &guifont="Consolas:h11"
  endif

  " Not Windows... Lucky you! "{{{2
else
  " ... we're not on windows, so just be normal.
  if has('gui_running')
    let &guifont="Cousine\ 11,dejavu\ sans\ mono\ for\ powerline\ 11"
  endif

  set clipboard=unnamedplus    " yank and copy to the X11 PRIMARY clipboard (selection)
  "http://vim.wikia.com/wiki/Accessing_the_system_clipboard
endif  " [/OS-Settings]<=
"  }}}

if has('gui_running')

  set go=aceg
  " [+c text dialogues instead of popups]
  " http://vimdoc.sourceforge.net/htmldoc/options.html#%27guioptions%27

  set guioptions-=m
  " menubar

  set guioptions-=r
  " scrollbar

  set go-=Tt
  " toolbar
endif

" }}}

" PLUGIN SETTINGS (GLOBALS)  {{{1

" Plugin: NERDTree
let g:NERDTreeBookmarksFile = expand('~/.cache/vim/NERDTreeBookmarks')
let g:NERDChristmasTree = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeSortOrder = []
let g:NERDTreeHijackNetrw = 0

" Plugin: NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDMenuMode = 0

" Plugin: INDENTLINE
let g:indentLine_color_term = 233
let g:indentLine_color_gui = '#121212'
let g:indentLine_char = '|'


if has("autocmd")
  " Resize splits with window
  au VimResized * :wincmd =

  " automatically leave insert mode after 'updatetime' ms of inacction
  " http://vim.wikia.com/wiki/To_switch_back_to_normal_mode_automatically_after_inaction
  au CursorHoldI * stopinsert
  " set 'updatetime' to 15 seconds when in insert mode
  au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
  au InsertLeave * let &updatetime=updaterestore

  " Restore cursor position
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

  " Autoreload vimrc.
  augroup reload_vimrc " {
    au!
    au BufWritePost $MYVIMRC source $MYVIMRC
  augroup END " }
endif


" }}}

" Increment-Activator {{{

" don't use <C-a> or <C-x>
let g:increment_activator_no_default_key_mappings = 1

" `'_'` is all files...
let g:increment_activator_filetype_candidates = {
      \   '_' : [
      \     ['VERBOTEN', 'erlaubt'],
      \     ['ACHTUNG', 'DANGER'],
      \     ['1-VL','2-L', '3-M', '4-H', '5-VH']
      \   ],
      \ }
" }}}

"}}}

" Code format & Indenting."{{{
set noautoindent     " auto indents next new line
set nosmartindent
set nocindent
set expandtab        " expand <Tabss with spaces
set shiftround       " always round indents to multiples of shiftwidth
set tabstop=2        " <Tab> move three characters
set shiftwidth=2     " >> and << shift 3 spaces
set softtabstop=2    " see spaces as tabs

set showbreak=…\     " show x in front of wrapped lines (trailing escaped space `\ `)
set textwidth=0      " disable hard wrap (e.g. set to 79 for new files)


set formatoptions=q  " Format text with gq, but don't format as I type.
set formatoptions+=n " gq recognizes numbered lists, and will try to
set formatoptions+=1 " break before, not after, a 1 letter word
set nowrap
set linebreak        " wrap long lines at a character in &breakat'


" }}}

" Interaction (Keys, Mouse)."{{{

let mapleader='\'
set backspace=2 " full backspacing capabilities (indent,eol,start)
set nojoinspaces     " never joing lines with two spaces

"set mouse=nv " enable mouse in normal, visual
set mouse=a
set mousehide     " Hide the mouse when typing text
set nostartofline " Avoid moving cursor to BOL when jumping around

set whichwrap=b,s,h,l,<,> " <BS> <Space> h l <Left> <Right> can change lines
set virtualedit=block " Let cursor move past the last char in <C-v> mode
set scrolloff=3 " Keep 3 context lines above and below the cursor
set backspace=2 " Allow backspacing over autoindent, EOL, and BOL
set showmatch " Briefly jump to a paren once it's balanced
set matchtime=2 " (for only .2 seconds).

set complete=.,w,b,u,t  " Better Completion TODO: g.
set completeopt=longest,menuone,preview

" }}}

" Visuals."{{{

"  Options."{{{
set cursorline            " track position

set noerrorbells          " no beeps on errors
set visualbell            " show visual bell
set title                 " show title in console title bar
set noruler               " no: display row, column and % of document
set showmatch             " show matching () {} etc.


" Commandline. "{{{

set history=1000
set wildmenu              " enhanced tab-completion shows all matching cmds in a popup menu
"}}}






set splitright " place new splits right & below


"}}}

" Listchars: show spaces, tab, eol trailing"{{{
set listchars=trail:·,precedes:«,extends:»,tab:▸\ ,eol:↲
set fillchars=fold:\ ,diff:╳,vert:│
"}}}

" Colorscheme."{{{
set synmaxcol=300 "Avoids editor lockup on extremely long lines

let g:jellyx_show_whitespace = 0
colorscheme jellyx

if has("gui_running")
  let g:jellyx_show_whitespace = 0
  colorscheme jellyx
  "colorscheme mirodark
  "colorscheme atom
else
  set list " fallback on invisibles ofr showing whitespace erros
  colorscheme ir_black
endif

"}}}

" Folding. {{{
fu! CustomFoldText()
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
endf
set foldtext=CustomFoldText()
set foldmethod=marker
set foldlevelstart=99
"set foldnestmax=4     " deepest fold level
"set foldenable      " start without folds
"set foldcolumn=1
"setlocal foldlevel=0
"}}}

" Line numbers."{{{
set nonumber                " don't show linenumbers by default

if exists("&relativenumber")
  "au InsertEnter * set norelativenumber
  "au InsertLeave * set relativenumber
endif
" }}}


" Searching."{{{
set incsearch " increment search
set ignorecase " case-insensitive search
set smartcase " uppercase causes case-sensitive search
"set hlsearch " included with colours -- highlight search results
set nogdefault " Disabled - See http://j.mp/1mZvnrt  (no `g` on `:s`)
"}}}

" }}}

" Files."{{{

" Keep old backups, write new ones. "{{{
set nobackup     " Disabled - See above (OS Settings)
set writebackup  "
"}}}

" Disabled - Superseeded by other functionality. {{{
" set noswapfile   " Disabled - See above (OS Settings)
" set exrc secure  " Disabled -  Per-directory .vimrc files without unsafe cmds
" set binary noeol " Disabled - Don’t add empty newlines at the end of files
set nomodeline     " Disabled - Using securemodelines plugin
" set modelines=5
" }}}

set noautowrite " Never write a file unless I request it.
set noautowriteall " NEVER.
"set noautoread " Don't automatically re-read changed files.
set ffs=unix,dos,mac " Try recognizing dos, unix, and mac line endings.


" Filetype misc."{{{
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

" Keybindings.  "{{{

" Modifier Normalization {{{1

let g:__NAMED_KEYCODES__ = {
      \ ' ': 'Space',
      \ '\': 'Bslash',
      \ '|': 'Bar',
      \ '<': 'lt'
      \ }


"source ~/.vim/local/modifiers.vim

" Since our mappings never timeout, a single ESC will hang indefinitely,
" waiting for a Meta/Mod4 sequence.
noremap! <Esc><Esc> <Esc>
" inoremap jj <Esc>

" (<S-Insert> | <Leaderv): Paste."{{{
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
noremap <Leader>v <ESC>:set paste<CR>i<C-r>+<Esc>:set nopaste<CR>
noremap <Leader>b <ESC>:set paste<CR>i<C-r>"<Esc>:set nopaste<CR>
"noremap <Leader>+p <ESC>:set paste<CR>i<C-r>"<Esc>:set nopaste<CR>
"}}}
"
" Load gui menus for terminal vim "{{{
if !has('gui_running')
  source $VIMRUNTIME/menu.vim
  map <F10> :emenu <C-Z>
endif
"}}}


" <Leader>dd to _ register (i.e. buffer)
nmap <silent> <leader>dd "_dd
vmap <silent> <leader>d "_d


" Timestamps, datestamps

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


" In normal/insert mode, ac center aligns the text after it to &tw or 80 chars
nnoremap <leader>ac :center<CR>


" Pressing an 'enter visual mode' key while in visual mode changes mode.
"vmap <C-V> <ESC>`<<C-v>`>
"vmap V <ESC>`<V`>
"vmap v <ESC>`<v`>
" (Disabled... confused about why I wanted this in the first place?)


" Center the cursor on the search word when using 'n'
" http://git.z3bra.org/cgit.cgi/dotfiles/tree/vimrc
nmap n nzz
nmap N Nzz

" Tabs."{{{

" Modifier keys broken by tmux [gh//20140922T0005Z]
" noremap <M-t> :tabnew<CR>
" noremap <M-d> :tabclose<CR>
" noremap <M-h> :tabp<CR>
" noremap <M-j> :tabp<CR>
" noremap <M-k> :tabn<CR>
" noremap <M-l> :tabn<CR>
noremap ,. :tabnew<CR>
noremap ., :tabclose<CR>
:nnoremap .l :tabn<CR>
:nnoremap .h :tabp<CR>

" :nnoremap <M-1> :tabn 1<CR>
" :nnoremap <M-2> :tabn 2<cr>
" :nnoremap <M-3> :tabn 3<cr>
" :nnoremap <M-4> :tabn 4<cr>
" :nnoremap <M-5> :tabn 5<cr>
" :nnoremap <M-6> :tabn 6<cr>
" :nnoremap <M-7> :tabn 7<cr>
" :nnoremap <M-8> :tabn 8<cr>
" :nnoremap <M-9> :tabn 9<cr>
"}}}

" splits."{{{
" this works beautifully with tmux: awareness of vim splits"
:noremap <C-h> <C-w>h
:noremap <C-j> <C-w>j
:noremap <C-k> <C-w>k
:noremap <C-l> <C-w>l
"}}}

" Folds. "{{{

" <space> toggle fold
nnoremap <space> za

" <space> in visual mode creates a fold over the marked range
vnoremap <space> zf

" <leader>\ clear hlsearch and redraw screen."{{{
noremap <silent> <Leader>\\ :nohls<cr><c-l><CR>
noremap <silent> /// :nohls<cr><c-l><CR>
"noremap <silent> <C-l> :nohls<cr><c-l><CR>
"}}}


" <Leader>ml - Append Modeline."{{{
" https://github.com/godlygeek/vim-files/blob/master/.vimrc#L346
" Insert a modeline on the last line with <leader>ml
nnoremap <Leader>ml :call ModelineStub()<CR>
"}}}


" <F6> Remove trailing spaces from lines
" " http://vim.wikia.com/wiki/Remove_unwanted_spaces
:nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


" (<F7> | \sp): Spell Check."{{{
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:noremap <Leader>sp :set spell!<cr>
:noremap <F7> :set spell!<cr>
"}}}

" <F9> toggles line numbers and turns off relative line numbers
nnoremap <silent> <F9> :set invnumber<CR>


" Q formats paragraphs, instead of entering ex mode
noremap Q gq
nnoremap <silent> gqJ :call Exe#ExeWithOpts('norm! gqj', { 'tw' : 2147483647 })<CR>

" <Leader>w write
noremap <Leader>w <Esc>:w<CR>

" <Leader>q quit
noremap <Leader>q <Esc>:q<CR>


" Plugin: Tabular. "{{{
" Key: <LEADER>a  (A for Align)

" Automatic"{{{
nnoremap <silent> <Leader>aa :Tabularize<CR>
vnoremap <silent> <Leader>aa :Tabularize<CR>


"}}}
" `=` Equals sign"{{{
nnoremap <silent> <Leader>a= :Tabularize /=<CR>
vnoremap <silent> <Leader>a= :GTabularize /^[^=]*\zs=\(*[*\)\@!/l1c1l0<CR>

"}}}
" `#` Hash comments"{{{
nnoremap <silent> <Leader>a# :Tabularize /#<CR>
vnoremap <silent> <Leader>a# :GTabularize /^[^#]*\zs=\(*[*\)\@!/l1c1l0<CR>
nnoremap <silent> <Leader>a3 :Tabularize /#<CR>
vnoremap <silent> <Leader>a3 :GTabularize /^[^#]*\zs=\(*[*\)\@!/l1c1l0<CR>
"}}}
" `"` Double-quotes for vim comments"{{{
nnoremap <silent> <Leader>a' :Tabularize /"<CR>
vnoremap <silent> <Leader>a' :Tabularize /"<CR>
nnoremap <silent> <Leader>a" :Tabularize /"<CR>
vnoremap <silent> <Leader>a" :Tabularize /"<CR>
"}}}
" `:` Colon assignments, JSON-safe style"{{{
nnoremap <silent> <Leader>a: :Tabularize /:\zs<CR>
vnoremap <silent> <Leader>a: :Tabularize /:\zs<CR>
"}}}
" `|` Pipes, cucumber tables"{{{
nnoremap <silent> <Leader>a\| :Tabularize /\|<CR>
vnoremap <silent> <Leader>a\| :Tabularize /\|<CR>
nnoremap <silent> <Leader>a\\ :Tabularize /\|<CR>
vnoremap <silent> <Leader>a\\ :Tabularize /\|<CR>
"}}}
"}}}


" Edit vimrc. {{{
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>
"}}}

" }}}



"}}}

" TERMINAL and GUI SETTINGS {{{1

if has('gui_running')
  """ GUI Settings

  " c - use console dialogs and prompts
  "set guioptions=c

  " Disable menus
  let g:did_install_default_menus = 1
  let g:did_install_syntax_menu = 1
  aunmenu *

  if has('gui_macvim')
    set fuoptions=maxvert,maxhorz
    set macmeta

    let g:macvim_skip_cmd_opt_movement = 1

    " Alias MacVim Command key to Super / Mod4
    let spkeys = [ 'Up', 'Down', 'Left', 'Right',
          \ 'S-Up', 'S-Down', 'S-Left', 'S-Right',
          \ 'CR', 'BS' ]
    for n in range(0x20, 0x7e) + spkeys
      let char = type(n) == type(0) ? nr2char(n) : n

      if type(n) == type(0)
        let char = nr2char(n)
        if has_key(g:__NAMED_KEYCODES__, char)
          let char = g:__NAMED_KEYCODES__[char]
        endif
      else
        let char = n
      endif

      execute 'map <special> <D-'.char.'> <4-'.char.'>'
      execute 'map! <special> <D-'.char.'> <4-'.char.'>'
    endfor
  endif
  " removed terminal modifer normalization here [Guy Hughes // 20150507T2131Z]

endif


