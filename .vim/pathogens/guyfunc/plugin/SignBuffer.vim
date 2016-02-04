func! s:SignVisualNDE()
    :'<,'>! gpg --sign --clearsign --quiet --not-dash-escaped 2>&/dev/null --
endfunction
command -range=% SignNotDashEscaped call SignVisual()

func! s:SignVisual()
    :'<,'>! gpg --sign --clearsign --quiet 2>&/dev/null --
endfunction
command -range=% -nargs=? Sign call SignVisual()
