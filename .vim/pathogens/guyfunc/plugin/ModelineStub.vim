"         __  __  ___  ___  ___ _    ___ _  _ ___ ___ _____ _   _ ___ 
"        |  \/  |/ _ \|   \| __| |  |_ _| \| | __/ __|_   _| | | | _ )
"        | |\/| | (_) | |) | _|| |__ | || .` | _|\__ \ | | | |_| | _ \
"        |_|  |_|\___/|___/|___|____|___|_|\_|___|___/ |_|  \___/|___/
" 
"                                  _             _           
"                   __ _ _  _ _  _| |_ _  _ __ _| |_  ___ ___
"                  / _` | || | || | ' \ || / _` | ' \/ -_|_-<
"                  \__, |\_,_|\_, |_||_\_,_\__, |_||_\___/__/
"                  |___/      |__/         |___/             
" Based on:
" https://github.com/godlygeek/vim-files/blob/master/.vimrc#L418
" 
" Uses NERDCommenter to comment the line.
"
"
" Make sure ml is not in first or last 5 lines!
"
"
"
"

function! ModelineStub()
  let io = (&fdm == 'marker' ? ' fmr='.&fmr : '')
  let io = io.( &et  ? ' et': ' noet').( &ro? ' ro' : '' )

  let ml = 'vim: set ft=%s tw=%d ts=%d sw=%d sts=%d fdm=%s%s:'
  let ml = printf(ml, &ft, &tw, &ts, &sw, &sts, &fdm, io  )
  let ml = substitute(substitute(ml, '\ \+', ' ', 'g'), ' $', '', '')
  :$put =ml
  :call NERDComment(1, "alignBoth")
endfunction

"                                  _             _           
"                   __ _ _  _ _  _| |_ _  _ __ _| |_  ___ ___
"                  / _` | || | || | ' \ || / _` | ' \/ -_|_-<
"                  \__, |\_,_|\_, |_||_\_,_\__, |_||_\___/__/
"                  |___/      |__/         |___/             

"         __  __  ___  ___  ___ _    ___ _  _ ___ ___ _____ _   _ ___ 
"        |  \/  |/ _ \|   \| __| |  |_ _| \| | __/ __|_   _| | | | _ )
"        | |\/| | (_) | |) | _|| |__ | || .` | _|\__ \ | | | |_| | _ \
"        |_|  |_|\___/|___/|___|____|___|_|\_|___|___/ |_|  \___/|___/



" vim: set ft=vim tw=80 ts=2 sw=2 sts=2 fdm=marker fmr={{{,}}} et:
