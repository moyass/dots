" lifted from pathogen
" https://github.com/tpope/vim-pathogen/blob/master/autoload/pathogen.vim 
function! s:warn(msg) abort
  echohl WarningMsg
  echomsg a:msg
  echohl NONE
endfunction

if ! has("clipboard")
  call s:warn('Not compiled with clipboard')
endif

if ! has ("python")
  call s:warn('Not compiled with python')
endif

