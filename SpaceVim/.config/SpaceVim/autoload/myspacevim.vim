function! myspacevim#before() abort

  autocmd BufRead,BufNewFile /usr/share/X11/xkb/* set syntax=xkb
  autocmd BufRead,BufNewFile ~/.dotfiles/Keyboard/usr/share/X11/xkb/* set syntax=xkb
  
  let g:mapleader = "'" " ' as leaader
  let g:material_theme_style = 'darker'

  set timeoutlen=500 " Guide buffer delay

endfunction

