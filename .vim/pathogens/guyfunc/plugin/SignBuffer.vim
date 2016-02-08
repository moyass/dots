func! s:SignVisualNDE()
    :'<,'>! gpg2 --sign --clearsign --quiet --not-dash-escaped 2>&/dev/null --
endfunction
command -range=% SignNotDashEscaped call s:SignVisualNDE()

func! s:SignVisual()
    :'<,'>! gpg2 --sign --clearsign --quiet 2>&/dev/null --
endfunction
command -range=% Sign call s:SignVisual()
