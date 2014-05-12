
" https://github.com/godlygeek/vim-files/blob/master/.vimrc#L418
" 
"
"
" Make sure var fmt is not in first or last 5 lines!
"
"
"
"


function! ModelineStub()
  let ios =  (&ro? " ro " : " ").(&et?"et":"noet")
  let fmt = ' vim: set ts=%d sts=%d ft=%s fdm=%s sw=%d%s: '
  let x = printf(&cms, printf(fmt, &ts, &sts, &ft, &fdm,  &sw, ios  ))
  return substitute(substitute(x, '\ \+', ' ', 'g'), ' $', '', '')
endfunction


" 
"
"
"
"
"
"
"
"
"
"


" vim: set ts=2 sts=2 ft=vim fdm=marker sw=2 et:
