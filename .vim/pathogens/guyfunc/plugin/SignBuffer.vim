func! SignBufferNotDashEscaped()
    :%! gpg --sign --clearsign --quiet --not-dash-escaped 2>&/dev/null --
endfunction
command SignBufferNotDashEscaped call SignBufferNotDashEscaped()

func! SignBuffer()
    :%! gpg --sign --clearsign --quiet 2>&/dev/null --
endfunction
command SignBuffer call SignBuffer()
