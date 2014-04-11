" 
" ~/.vimrc
" 

" ==============================================================================
" Standard. (syntax, utf8, ft, nocompatible, clipboard, 256 ) "{{{
" ==============================================================================
filetype plugin on
filetype indent on
set nocompatible          " leave the old ways behind
set encoding=utf-8 nobomb " UTF-8 encoding for all new files
set clipboard+=unnamed    " yank and copy to the OS clipboard
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
  let myguifont="Consolas:h11"

  if (&guifont != myguifont)
    execute "set guifont=".myguifont
  endif

  let s:vimbackups='$MYVIMRC/../vimtmp' 
  set directory=s:vimbackups " swapfiles
  set noswapfile      " no swap on windows
  set backupdir=s:vimbackups
  set backup        " no backup on windows
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
  set directory=/tmp " put swapfiles in /tmp instead of current directory.
  set backupdir=~/.vim/backups
  if exists("&undodir")
    set undodir=~/.vim/undo
  endif

endif  " [/OS-Settings]<=
" }}}

if has('gui_running') 
  set guioptions+=aceg " [+c text dialogues instead of popups]
  " http://vimdoc.sourceforge.net/htmldoc/options.html#%27guioptions%27
  set guioptions-=m   " menubar
  set guioptions-=r   " scrollbar
  set guioptions-=Tt  " toolbar
endif

" }}}
" ==============================================================================

" ==============================================================================
" Code format & Indenting."{{{
" ==============================================================================
set autoindent      " auto indents next new line
set nosmartindent
set nocindent
set expandtab       " expand tabs with spaces
set tabstop=2       " <Tab> move three characters
set shiftwidth=2    " >> and << shift 3 spaces
set softtabstop=2   " see spaces as tabs
set showbreak=...\  " show x in front of wrapped lines (trailing escaped space `\ `)
set textwidth=0     " disable hard wrap (e.g. set to 79 for new files)
set wrap
set linebreak       " wrap long lines at a character in &breakat

" }}}
" ==============================================================================

" ==============================================================================
" Interaction (Keys, Mouse)."{{{
" ==============================================================================
let mapleader="\\"
set backspace=2 " full backspacing capabilities (indent,eol,start)
set mouse=a " enable mouse in all modes
set mousehide     " Hide the mouse when typing text
set nostartofline

set complete=.,w,b,u,t  " Better Completion TODO: add more
set completeopt=longest,menuone,preview

" }}}
" ==============================================================================

" ==============================================================================
" Visuals."{{{
" ==============================================================================

"  Options."{{{
" ==================================================
set cursorline            " track position
set scrolloff=2          " keep x lines of context
set ttyfast

set noerrorbells          " no beeps on errors
set visualbell            " show visual bell
set title                 " show title in console title bar
set noruler               " no: display row, column and % of document
set showmatch             " show matching () {} etc.
set wildmenu              " enhanced tab-completion shows all matching cmds in a popup menu
set splitright " place new splits right & below
set splitbelow

if has("autcmd")
  au VimResized * :wincmd = " resize splits with window
endif"}}}

" Listchars: show spaces, tab, eol trailing"{{{
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\
"}}}

" Colorscheme."{{{
" ==================================================
if has("gui_running")
  colorscheme ir_black
else
  "if exists('$WINDOWID') && &term =~ "rxvt"
  colorscheme miromiro
  "else
  "  colorscheme miro8
  "endif
  " Disabled - 8-color vim ... only useful for lazy/braindead ssh.
endif

"}}}

" Folding. {{{
" ==================================================
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

" Statusline < Powerline with Airline."{{{
" ==================================================
set cmdheight=1
set showcmd               " show partial commands in the status line
set showmode              " show current mode
set laststatus=2 " turns status line always on and configures it

if exists('$WINDOWID') && &term =~ "rxvt"
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_theme = "powerlineish"
else
  set statusline=%<%f\ %m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P\ of\ %L
endif

" }}}

" }}}
" ==============================================================================

" ==============================================================================
" Files."{{{
" ==============================================================================
"set nobackup    " Disabled - See above (OS Settings)
"set noswapfile  " Disabled - See above (OS Settings) 
"set exrc secure " Per-directory .vimrc files without unsafe cmds
"set binary noeol  " Don’t add empty newlines at the end of files
"set modeline    " Disabled - Using securemodelines plugin
"set modelines=5 

" ==================================================
" Filetype misc."{{{
" ==================================================
if has("autocmd")
  " Restore cursor position
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

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
  " Vim Plugins.  "{{{
  " ==============================================================================

  " Autoreload vimrc.
  if has("autocmd")
    augroup reload_vimrc " {
      au!
      au BufWritePost $MYVIMRC source $MYVIMRC
    augroup END " }
  endif

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
    call pathogen#infect($VIM.'\vimfiles\bundle\{}')
  else
    " pathogen: plugins in $HOME/.vim/bundle/**
    call pathogen#infect('~/.vim/bundle/{}')
  endif

  call pathogen#helptags()

  "}}}

  "}}}
  " ==============================================================================

  " ==============================================================================
  " Keybindings.  "{{{ 
  " ==============================================================================

  " Shift + Insert = Paste."{{{
  " ==================================================
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
  "}}}

  " Switch colon and semi-colon
  nnoremap ; :
  nnoremap : ;
  vnoremap ; :
  vnoremap : ;

  " <Leader>d to _ buffer
  nmap <silent> <leader>d "_d 
  vmap <silent> <leader>d "_d

  " Insert new line after the cursor with shift+enter
  nmap <S-CR> i<Enter><Esc>l


  "Open a Quickfix window for the last search. 
  nnoremap <silent> ,/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

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

  " Toggle fold
  nnoremap <space> za

  " Create and destroy folds with space. 
  " https://github.com/icco/dotFiles/blob/master/link/vimrc
  " Vulnerable to spacebar attack from domesticated animals.
  " Especially significant others. Like ghosts.
  ":vnoremap <space> zf<CR>
  ":nnoremap <space> zd<CR>
  "}}}

  " Clear hlsearch. Noh!"{{{
  " ==================================================
  :map <silent> <Leader>\\ :nohls<cr>; echo 'Suche-Highlight ist weg' <CR> 
  :map <silent> // :nohls<cr>; echo 'Suche-Highlight ist weg' <CR> 
  "}}}

  " Spell Check."{{{
  " ==================================================
  " https://github.com/icco/dotFiles/blob/master/link/vimrc
  " vim: ts=2:sw=2:tw=80:et :
  :map <Leader>sp :set spell!<cr>
  "}}}

  " Append modeline to file."{{{
  " ==================================================
  " http://vim.wikia.com/wiki/Modeline_magic
  nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
  "}}}

  " Disabled -- Kill the arrow keys."{{{
  " ==================================================
  " Discipline? Security? Fascism? 1334? scriptkiddie?
  "inoremap  <Up>     <NOP>  " This protects yourself
  "inoremap  <Down>   <NOP> " from your worst enemy
  "inoremap  <Left>   <NOP> " ... yourself. But only
  "inoremap  <Right>  <NOP> " if you enable it.

  "noremap   <Up>     <NOP> " This helps you save
  "noremap   <Down>   <NOP> " time by making you
  "noremap   <Left>   <NOP> " type 20j instead of
  "noremap   <Right>  <NOP> " scrolling like a moron.
  "}}}

  " Plugin: Tabular. "{{{
  " ==================================================
  " Key: <LEADER>a  (A for Align)

  " Automatic"{{{
  nnoremap <silent> <Leader>aa :Tabularize<CR>
  vnoremap <silent> <Leader>aa :Tabularize<CR>
  "}}}
  " `=` Equals sign"{{{
  nnoremap <silent> <Leader>a= :Tabularize /=<CR>
  vnoremap <silent> <Leader>a= :Tabularize /=<CR>
  "}}}
  " `#` Hash comments"{{{
  nnoremap <silent> <Leader>a# :Tabularize /"<CR>
  vnoremap <silent> <Leader>a# :Tabularize /"<CR>
  nnoremap <silent> <Leader>a3 :Tabularize /"<CR>
  vnoremap <silent> <Leader>a3 :Tabularize /"<CR>
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

  " Plugin: guys-laundry."{{{
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
  nnoremap <Leader>v :tabnew $MYVIMRC<CR>
  "}}}

  " }}} 
  " ==============================================================================

  " vim: ts=2:sw=2:tw=78:fdm=marker:et :


