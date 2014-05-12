" Ryanw
"https://bitbucket.org/jasonwryan/centurion/src
"
" Notice how colour is spelled correctly except for the reference to
" the option where necessary? This makes a world of difference.
"
" toggle coloured right border after 80 chars
set colorcolumn=0
let s:colour_column_old = 80

function! s:ToggleColourColumn()
    if s:colour_column_old == 0
        let s:colour_column_old = &colorcolumn
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn=s:colour_column_old
        let s:colour_column_old = 0
    endif
endfunction
command! -nargs=? ColourColumn call s:ToggleColourColumn()
