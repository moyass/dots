func! FormatJSON()
  :%!python -m json.tool
endfunction
command FormatJSON call FormatJSON()
