"
" ~/.vimrc
"
if has('autocmd')
  autocmd!
endif

" Vundle.                                                 "{{{1

" vundle pre-reqs
set nocompatible
filetype off

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    " https://github.com/fisadev/fisa-vim-config/blob/master/.vimrc
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'gmarik/vundle'

" Airline: 'Thanks for flying vim!'
Plugin 'bling/vim-airline', {'name': 'airline'}
Plugin 'editorconfig/editorconfig-vim', {'name': 'cfg-editorconfig'}
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim', {'name': 'keys-ctrlp'}
Plugin 'gcmt/wildfire.vim', {'name': 'keys-return-wildfire'}
Plugin 'nishigori/increment-activator', {'name': 'keys-incrementactivator'}
Plugin 'jiangmiao/auto-pairs', {'name': 'keys-autopairs'}
Plugin 'tpope/vim-eunuch', {'name': 'cmds-eunuch'}
Plugin 'grep.vim', {'name': 'cmds-grep'}
Plugin 'DirDiff.vim', {'name': 'cmds-dirdiff'}

" Syntax
Plugin 'scrooloose/syntastic', {'name': 'syntax-syntastic'}
Plugin 'sheerun/vim-polyglot', {'name': 'syntax-polyglot'}
Plugin 'potatoesmaster/i3-vim-syntax', {'name': 'syntax-i3wm'}
Plugin 'git://fedorapeople.org/home/fedora/wwoods/public_git/vim-scripts.git', {'name': 'syntax-systemd'}

" VCS, Git
Plugin 'airblade/vim-gitgutter', {'name': 'git-gitgutter'}
Plugin 'tpope/vim-fugitive', {'name': 'git-fugitive'}

" Gist
Plugin 'mattn/webapi-vim', {'name': 'gist-webapi'}
Plugin 'mattn/gist-vim', {'name': 'gist'}


" Colours
Bundle 'w0ng/vim-hybrid', {'name': 'colours-w0ng-hybrid'}
Bundle 'guns/jellyx.vim', {'name': 'colors-guns-jellyx'}

" Experimental::
" Extension to ctrlp, for fuzzy command finder
Bundle 'fisadev/vim-ctrlp-cmdpalette'
" Terminal Vim with 256 colors colorscheme
Bundle 'fisadev/fisa-vim-colorscheme'
" Surround
Bundle 'tpope/vim-surround'
" Autoclose
Bundle 'Townk/vim-autoclose'

if iCanHazVundle == 0
 echo "Installing Bundles, please ignore key map error messages"
 echo ""
 :PluginInstall
endif

call vundle#end()
"}}}

" Standard. (syntax, utf8, ft, nocompatible, clipboard, 256 ) "{{{1
filetype plugin on
filetype indent on
set nocompatible          " leave the old ways behind
set encoding=utf-8 nobomb " UTF-8 encoding for all new files
set shortmess=aoOstTAI   "shorten all messages except written
"set notimeout ttimeout  " Wait for mappings, timeout on keycodes
set timeout ttimeout
"set ttimeoutlen=0

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
 
  set clipboard=unnamed    " yank and copy to the X11 PRIMARY clipboard (selection)
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

" Plugin: GISTS
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1
let g:gist_post_private = 1
let g:gist_get_multiplefile = 1


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

" Statusline < Powerline with Airline."{{{
set report=0              " report back on all change
set cmdheight=1
set showcmd               " show partial commands in the status line
set showmode              " show current mode
set laststatus=2 " turns status line always on and configures it

  let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V-LINE',
      \ '' : 'V-BLOCK',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }
"if exists('$WINDOWID') && &term =~ "rxvt"
if exists('$WINDOWID') && &term =~ "256"
  let g:airline_powerline_fonts = 1
  "let g:airline#extensions#tabline#enabled = 1
  let g:airline_theme = "kolor"
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"
else
  set statusline=%<%f\ %m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P\ of\ %L
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

" Pathogen."{{{
" This comes after the `let g:*` statements above so that they are in force (like
" the law) when the bundles are added to `set runtimepath` for the first time.
" ACHTUNG: If you screw this up, then you will screw up everything.

if has ("win32") " returns 1 on WOW64
  " pathogen: plugins in $VIM/vimfiles/bundle/**
  call pathogen#infect($VIM.'\vimfiles\pathogens\{}')
else
  " pathogen: plugins in $HOME/.vim/bundle/**
  call pathogen#infect($HOME.'/.vim/pathogens/{}')
endif

call pathogen#helptags()

"}}}

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
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\
set fillchars=fold:\ ,diff:╳,vert:│
"}}}

" Colorscheme."{{{
set synmaxcol=300 "Avoids editor lockup on extremely long lines

if has("gui_running") || &t_Co == 256
  let g:jellyx_show_whitespace = 1
  colorscheme jellyx
  "colorscheme mirodark
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

" Since our mappings never timeout, a single ESC will hang indefinitely,
" waiting for a Meta/Mod4 sequence.
noremap! <Esc><Esc> <Esc>

" (<S-Insert> | <Leaderv): Paste."{{{
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
noremap <Leader>v <ESC>:set paste<CR>i<C-r>*<Esc>:set nopaste<CR>
"}}}

" Load gui menus for terminal vim "{{{
if !has('gui_running')
  source $VIMRUNTIME/menu.vim
  map <F10> :emenu <C-Z>
endif
"}}}

" Switch colon and semi-colon"{{{
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
"}}}

" <Leader>d to _ buffer
nmap <silent> <leader>dd "_d
vmap <silent> <leader>d "_d


" TODO: Fix :AlignRight
" Disabled -- AlignRight is broken
"normal/insert mode, ar inserts spaces to right align to &tw or 80 chars
"nnoremap <leader>ar :AlignRight<CR>

" In normal/insert mode, ac center aligns the text after it to &tw or 80 chars
nnoremap <leader>ac :center<CR>

" Plugin: https://github.com/nishgori/increment-activator
nmap <M-a> <Plug>(increment-activator-increment)
nmap <M-x> <Plug>(increment-activator-decrement)

" Pressing an 'enter visual mode' key while in visual mode changes mode.
"vmap <C-V> <ESC>`<<C-v>`>
"vmap V <ESC>`<V`>
"vmap v <ESC>`<v`>
" (Disabled... confused about why I wanted this in the first place?)

"Open a Quickfix window for the last search.
nnoremap <silent> ,/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Center the cursor on the search word when using 'n'
" http://git.z3bra.org/cgit.cgi/dotfiles/tree/vimrc
nmap n nzz
nmap N Nzz

" Tabs."{{{
" https://github.com/icco/dotFiles/blob/master/link/vimrc
" @author David Patierno
:nnoremap ,. :tabnew<CR>
:nnoremap ., :tabclose<CR>
:nnoremap .q :tabp<CR>
:nnoremap .e :tabn<CR>
:nnoremap .1 :tabn 1<CR>
:nnoremap .2 :tabn 2<CR>
:nnoremap .3 :tabn 3<CR>
:nnoremap .4 :tabn 4<CR>
:nnoremap .5 :tabn 5<CR>
:nnoremap .6 :tabn 6<CR>
:nnoremap .7 :tabn 7<CR>
:nnoremap .8 :tabn 8<CR>
:nnoremap .9 :tabn 9<CR>"}}}

" Splits."{{{
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:nnoremap .w <c-w><Up><CR>
:nnoremap .s <c-w><Down><CR>
" don't use <C-a> or <C-x>
:nnoremap .a <c-w><Left><CR>
:nnoremap .d <c-w><Right><CR>
" don't use <C-a> or <C-x>"}}}

" Folding."{{{

" <Space> Toggle fold
nnoremap <space> za

" <Space> in visual mode creates a fold over the marked range
vnoremap <space> zf

" <Leader>\ Clear hlsearch and redraw screen."{{{
noremap <silent> <Leader>\\ :nohls<cr><c-l><CR>
noremap <silent> <c-l> :nohls<cr><c-l><CR>
"}}}


" <Leader>ml - Append Modeline."{{{
" https://github.com/godlygeek/vim-files/blob/master/.vimrc#L346
" Insert a modeline on the last line with <leader>ml
nnoremap <Leader>ml :$put =ModelineStub()<CR>
"}}}

" Disabled -- Kill the arrow keys."{{{
" Discipline? Fascism? 1334? scriptkiddie?
"inoremap  <Up>     <NOP>  " This protects yourself
"inoremap  <Down>   <NOP> " from your worst enemy
"inoremap  <Left>   <NOP> " ... yourself. But only
"inoremap  <Right>  <NOP> " if you enable it.

"noremap   <Up>     <NOP> " This helps you save
"noremap   <Down>   <NOP> " time by making you
"noremap   <Left>   <NOP> " type 20j instead of "noremap   <Right>  <NOP> " scrolling like a moron.
""}}}

" <Leader>sq to squeeze blank lines with :Squeeze
nnoremap <leader>sq :Squeeze<CR>

" <Leader>box draws a box around the highlighted text.
vnoremap <leader>box <ESC>:call BoxIn()<CR>gvlolo

" <F6> Remove trailing spaces from lines
" " http://vim.wikia.com/wiki/Remove_unwanted_spaces
:nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


" (<F7> | \sp): Spell Check."{{{
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:noremap <Leader>sp :set spell!<cr>
:noremap <F7> :set spell!<cr>
"}}}

" <F8> toggles LongLineHighlight
nnoremap <F8> :call LongLineHighlight()<CR>

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

" Plugin: nerdy-laundry."{{{
" Enable LAUNDRY keybinds
" let g:laundry_defaultkeys = 1

" Development mode {{{
" if exists('g:laundry_defaultkeys')
"  g:laundry_no_default_key_mappings = 0
" endif
" " }}}

"}}}

" Edit vimrc. {{{
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>
"}}}

" }}}


" Modifier Normalization {{{1

let g:__NAMED_KEYCODES__ = {
    \ ' ': 'Space',
    \ '\': 'Bslash',
    \ '|': 'Bar',
    \ '<': 'lt'
\ }

source ~/.vim/local/modifiers.vim

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
else
  """ Terminal Settings
  " http://vim-fr.org/index.php/Julm

  "set mouse=a         " Enable full mouse support
  set ttymouse=xterm2 " More accurate mouse tracking
  set ttyfast         " More redrawing characters sent to terminal

  " From ECMA-48:
  "
  "   OSC - OPERATING SYSTEM COMMAND:
  "     Representation: 09/13 or ESC 05/13 (this is \033] here)
  "     OSC is used as the opening delimiter of a control string for
  "     operating system use.  The command string following may consist
  "     of a sequence of bit combinations in the range 00/08 to 00/13 and
  "     02/00 to 07/14.  The control string is closed by the terminating
  "     delimiter STRING TERMINATOR (ST).  The interpretation of the
  "     command string depends on the relevant operating system.
  "
  " From man screen:
  "
  "   Virtual Terminal -> Control Sequences:
  "     ESC P  (A)  Device Control String
  "                 Outputs a string directly to the host
  "                 terminal without interpretation.
  "     ESC \  (A)  String Terminator
  "
  " From tmux OpenBSD patchset 866:
  "
  "   Support passing through escape sequences to the underlying terminal
  "   by using DCS with a "tmux;" prefix. Escape characters in the
  "   sequences must be doubled. For example:
  "
  "   $ printf '\033Ptmux;\033\033]12;red\007\033\\'
  "
  "   Will pass \033]12;red\007 to the terminal (and change the cursor
  "   colour in xterm). From Kevin Goodsell.
  "
  " From tmux OpenBSD patchsets 915 and 916:
  "
  "   Support xterm(1) cursor colour change sequences through terminfo(5) Cc
  "   (set) and Cr (reset) extensions. Originally by Sean Estabrooks, tweaked
  "   by me and Ailin Nemui.
  "
  "   Support DECSCUSR sequence to set the cursor style with two new
  "   terminfo(5) extensions, Cs and Csr. Written by Ailin Nemui.
  "
  "   NOTE: The following commit appears to break this feature.
  "
  "   commit 13441e8cb8b0ce68db3204a44bbdc004bee42a0f
  "   Author: Nicholas Marriott <nicm@openbsd.org>
  "   Date:   4 months ago
  "
  "       The actual terminfo entries we ended up with for cursor changes are Cs,
  "       Ce, Ss and Se (not Cc, Ce, Cs, Csr). So use and document these instead
  "       of the ones we were using earlier.
  "
  " From :help t_SI:
  "
  "   Added by Vim (there are no standard codes for these):
  "     t_SI start insert mode (bar cursor shape)
  "     t_EI end insert mode (block cursor shape)

  if &t_Co == 256
      let s:icolor = 'rgb:00/CC/FF'
      let s:ncolor = 'rgb:FF/F5/9B'

      if exists('$TMUX') || &term =~ '\v^tmux'
          let &t_SI = "\033Ptmux;\033\033]12;" . s:icolor . "\007\033\\"
          let &t_EI = "\033Ptmux;\033\033]12;" . s:ncolor . "\007\033\\"
      elseif &term =~ '\v^screen'
          let &t_SI = "\033P\033]12;" . s:icolor . "\007\033\\"
          let &t_EI = "\033P\033]12;" . s:ncolor . "\007\033\\"
      elseif &term =~ '\v^u?rxvt|^xterm'
          let &t_SI = "\033]12;" . s:icolor . "\007"
          let &t_EI = "\033]12;" . s:ncolor . "\007"
      endif
  endif
endif
