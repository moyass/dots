
" ==================================================
" Shift Insert paste.
" ==================================================
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" ==================================================
" Tabs.
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
:nnoremap .9 :tabn 9<CR>


" ==================================================
" Splits.
" ==================================================
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:nnoremap .w <c-w><Up><CR>
:nnoremap .s <c-w><Down><CR>
:nnoremap .a <c-w><Left><CR>
:nnoremap .d <c-w><Right><CR>

" ==================================================
" Folding.
" ==================================================
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:vnoremap <space> zf<CR>
:nnoremap <space> zd<CR>

" ==================================================
" Clear hlsearch. Noh!
" ==================================================
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:noremap <silent> <Leader>l :nohls<cr><c-l>

" ==================================================
" Spell Check.
" ==================================================
" https://github.com/icco/dotFiles/blob/master/link/vimrc
:map <Leader>sp :set spell!<cr>

" ==================================================
" Append modeline to file.
" ==================================================
" http://vim.wikia.com/wiki/Modeline_magic  
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


" ==================================================
" Disable arrow keys. Discipline. Security.
" ==================================================
"inoremap  <Up>     <Up>  " This protects yourself
"inoremap  <Down>   <NOP> " from your worst enemy
"inoremap  <Left>   <NOP> " ... yourself. But only
"inoremap  <Right>  <NOP> " if you enable it.

"noremap   <Up>     <NOP> " This helps you save
"noremap   <Down>   <NOP> " time by making you
"noremap   <Left>   <NOP> " type 20j instead of
"noremap   <Right>  <NOP> " scrolling like a moron.

" ==================================================
" Tabular.
" ==================================================
" <LEADER>A for ALIGN
nnoremap <silent> <Leader>a= :Tabularize /=<CR>
vnoremap <silent> <Leader>a= :Tabularize /=<CR>
nnoremap <silent> <Leader>a' :Tabularize /"<CR>
vnoremap <silent> <Leader>a' :Tabularize /"<CR>
nnoremap <silent> <Leader>a" :Tabularize /"<CR>
vnoremap <silent> <Leader>a" :Tabularize /"<CR>
nnoremap <silent> <Leader>a: :Tabularize /:\zs<CR>
vnoremap <silent> <Leader>a: :Tabularize /:\zs<CR>
"nnoremap <silent> <Leader>a\| :Tabularize /|<CR>
"vnoremap <silent> <Leader>a\| :Tabularize /|<CR>


" ==================================================
" Underline.
" ==================================================
nnoremap <Leader>uu :Underline<CR>
nnoremap <Leader>uo :UnderlineAndOverline<CR>

" vim: ts=2:sw=2:tw=78:et :
