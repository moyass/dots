func! SignBuffer()
    :%! gpg --sign --clearsign --quiet --not-dash-escaped 2>&/dev/null --
endfunction
command SignBuffer call SignBuffer()
