" 
" ~/.vimrc
" 

" ==============================================================================
" Vundle. "{{{1"{{{
" ==============================================================================

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
" ==============================================================================

" ==============================================================================
" Standard. (syntax, utf8, ft, nocompatible, clipboard, 256 ) "{{{1
" ==============================================================================
filetype plugin on
filetype indent on
set nocompatible          " leave the old ways behind
set encoding=utf-8 nobomb " UTF-8 encoding for all new files
set clipboard=unnamed    " yank and copy to the OS clipboard
set shortmess=atI
set notimeout             " fix timeouts in terminal vim
set ttimeout
set ttimeoutlen=10

if &t_Co > 2 || has("gui_running" )
  set t_Co=256 " 256 colors please
  syntax on
  set hlsearch " highlighted search
endif
"}}}
" ==============================================================================

" ==============================================================================
"  OS Settings  {{{
" ==============================================================================

" Windows... pitiful... "{{{
" ==================================================
if has("gui_win32") " returns 1 on WOW64  =>[OS-Settings]
  " ... do nonsense.

  " Stupid hack to prevent Win7-gvim window unsapping when vimrc autoreloads
  let s:myguifont="Consolas:h11"


  let s:vimbackups='$MYVIMRC/../vimtmp' 
  set directory^=s:vimbackups " swapfiles
  set noswapfile      
  set backupdir^=s:vimbackups
  " Disabled - assume %USERPROFILE% is on a network share,
  " this is better for performance.
  if exists("&undodir")
    set undodir=$MYVIMRC/../vimbackups
  endif
  "}}}

  " Not Windows... Lucky you! "{{{
  " ==================================================
else
  " ... we're not on windows, so just be normal.
  set directory^=/tmp " put swapfiles in /tmp instead of current directory.
  set backupdir^=~/.vim/backups
  let s:myguifont="Source\ Code\ Pro\ for\ Powerline\ 11"
  if exists("&undodir")
    set undodir^=~/.vim/undo
  endif
  set noswapfile
endif  " [/OS-Settings]<=
"  }}}

if has('gui_running') 

  if (&guifont != s:myguifont)
    :let &guifont=s:myguifont
  endif
  
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
" ==============================================================================

" ==============================================================================
" Vim Plugins.  {{{
" ==============================================================================

" INDENTLINE plugin
let g:indentLine_color_term = 233
let g:indentLine_color_gui = '#121212'
let g:indentLine_char = '|'

" GISTS
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

  " Restore cursor position
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Autoreload vimrc.
    augroup reload_vimrc " {
      au!
      au BufWritePost $MYVIMRC source $MYVIMRC
    augroup END " }
  endif

" Statusline < Powerline with Airline."{{{
" ==================================================
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
" ==================================================

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
" ==================================================
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
" ==============================================================================

" ==============================================================================
" Code format & Indenting."{{{
" ==============================================================================
set noautoindent      " auto indents next new line
set nosmartindent
set nocindent
set expandtab       " expand tabs with spaces
set tabstop=2       " <Tab> move three characters
set shiftwidth=2    " >> and << shift 3 spaces
set softtabstop=2   " see spaces as tabs
set showbreak=...\  " show x in front of wrapped lines (trailing escaped space `\ `)
set textwidth=0     " disable hard wrap (e.g. set to 79 for new files)
set formatoptions=q " Format text with gq, but don't format as I type.
set formatoptions+=n " gq recognizes numbered lists, and will try to
set formatoptions+=1 " break before, not after, a 1 letter word
set wrap
set linebreak       " wrap long lines at a character in &breakat

" }}}
" ==============================================================================

" ==============================================================================
" Interaction (Keys, Mouse)."{{{
" ==============================================================================
let mapleader="\\"
set backspace=2 " full backspacing capabilities (indent,eol,start)
"set mouse=nv " enable mouse in normal, visual
set mouse=a
set mousehide     " Hide the mouse when typing text
set nostartofline " Avoid moving cursor to BOL when jumping around
set ttyfast

set whichwrap=b,s,h,l,<,> " <BS> <Space> h l <Left> <Right> can change lines
set virtualedit=block " Let cursor move past the last char in <C-v> mode
set scrolloff=3 " Keep 3 context lines above and below the cursor
set backspace=2 " Allow backspacing over autoindent, EOL, and BOL
set showmatch " Briefly jump to a paren once it's balanced
set matchtime=2 " (for only .2 seconds).

set complete=.,w,b,u,t  " Better Completion TODO: g.
set completeopt=longest,menuone,preview

" }}}
" ==============================================================================

" ==============================================================================
" Visuals."{{{
" ==============================================================================

"  Options."{{{
" ==================================================
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
"}}}

" Colorscheme."{{{
" ==================================================
"if has("gui_running")
 " colorscheme ir_black
"else
  "if exists('$WINDOWID') && &term =~ "rxvt"
colorscheme mirodark
  "else
  "  colorscheme miro8
  "endif
  " Disabled - 8-color vim ... only useful for lazy/braindead ssh.
"endif

"}}}

" Folding. {{{
" ==================================================
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
"set foldnestmax=4     " deepest fold level
"set foldenable      " start without folds
"set foldcolumn=1
"setlocal foldlevel=0
"}}}

" Line numbers."{{{
" ==================================================
set number                " show linenumbers by default

if exists("&relativenumber")
  au InsertEnter * set norelativenumber number
  au InsertLeave * set relativenumber number
endif
" }}}


" Searching."{{{
" ==================================================
set incsearch " increment search
set ignorecase " case-insensitive search
set smartcase " uppercase causes case-sensitive search
"set hlsearch " included with colours -- highlight search results
set nogdefault " Disabled - See http://j.mp/1mZvnrt  (no `g` on `:s`)
"}}}

" }}}
" ==============================================================================

" ==============================================================================
" Files."{{{
" ==============================================================================

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
" ==================================================
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
" ==============================================================================

" ==============================================================================
" Keybindings.  "{{{ 
" ==============================================================================

" (<S-Insert> | <Leaderv): Paste."{{{
" ==================================================
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
" ==================================================
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
" ==================================================
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:nnoremap .w <c-w><Up><CR>
:nnoremap .s <c-w><Down><CR>
" don't use <C-a> or <C-x>
:nnoremap .a <c-w><Left><CR>
:nnoremap .d <c-w><Right><CR>
" don't use <C-a> or <C-x>"}}}

" Folding."{{{
" ==================================================

" <Space> Toggle fold
nnoremap <space> za

" <Space> in visual mode creates a fold over the marked range
vnoremap <space> zf

" <Leader>\ Clear hlsearch and redraw screen."{{{
" ==================================================
noremap <silent> <Leader>\\ :nohls<cr><c-l><CR> 
noremap <silent> <c-l> :nohls<cr><c-l><CR> 
"}}}


" <Leader>ml - Append Modeline."{{{
" ==================================================
" https://github.com/godlygeek/vim-files/blob/master/.vimrc#L346
" Insert a modeline on the last line with <leader>ml
nnoremap <Leader>ml :$put =ModelineStub()<CR>
"}}}

" Disabled -- Kill the arrow keys."{{{
" ==================================================
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
" ==================================================
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:noremap <Leader>sp :set spell!<cr>
:noremap <F7> :set spell!<cr>
"}}}

" <F8> toggles LongLineHighlight
nnoremap <F8> :call LongLineHighlight()<CR>

" <F9> toggles line numbers and turns off relative line numbers 
nnoremap <silent> <F9> :set invnumber<CR>:set norelativenumber <CR>


" Q formats paragraphs, instead of entering ex mode
noremap Q gq
nnoremap <silent> gqJ :call Exe#ExeWithOpts('norm! gqj', { 'tw' : 2147483647 })<CR>

" <Leader>w write
noremap <Leader>w <Esc>:w<CR>

" <Leader>q quit
noremap <Leader>q <Esc>:q<CR> 


" Plugin: Tabular. "{{{
" ==================================================
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
" ==================================================
" Enable LAUNDRY keybinds
" let g:laundry_defaultkeys = 1

" Development mode {{{
" if exists('g:laundry_defaultkeys')
"  g:laundry_no_default_key_mappings = 0 
" endif
" " }}}

"}}}

" Edit vimrc. {{{
" ==================================================
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>
"}}}

" }}} 
" }}} 
" ==============================================================================








