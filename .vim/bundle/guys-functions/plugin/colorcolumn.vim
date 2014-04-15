" Ryanw
"https://bitbucket.org/jasonwryan/centurion/src
" toggle colored right border after 80 chars
set colorcolumn=0
let s:color_column_old = 80

function! s:ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction
command! -nargs=? ColourColumn call s:ToggleColourColumn()
