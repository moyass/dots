" Append modeline after last line in buffer.
" http://vim.wikia.com/wiki/Modeline_magic 
function! AppendModeline()
  let l:modeline = printf(" vim: ts=%d:sw=%d:tw=%d:%set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
