
function! s:Underline(chars)
  let chars = empty(a:chars) ? '=' : a:chars
  let nr_columns = 50 " virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
  normal gcc
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)

function! s:UnderlineAndOverline(chars)
  let chars = empty(a:chars) ? '=' : a:chars
  let nr_columns = 50 " virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
  normal gcc2k
  put =strpart(uline, 0, nr_columns)
  normal gcc
endfunction
command! -nargs=? UnderlineAndOverline call s:UnderlineAndOverline(<q-args>) 
