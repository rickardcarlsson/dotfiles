function! myspacevim#before() abort

  " Mappings
  " AltGr+. Repeat last command on selected lines
  noremap · :'<,'>norm .<CR> 

  autocmd BufRead,BufNewFile /usr/share/X11/xkb/* set syntax=xkb
  autocmd BufRead,BufNewFile ~/.dotfiles/Keyboard/usr/share/X11/xkb/* set syntax=xkb
  
  let g:mapleader = "'" " ' as leaader

  if $LIGHTMODE == 'true'
    let g:material_theme_style = 'lighter'
  else
    let g:material_theme_style = 'darker'
  endif

  set timeoutlen=500 " Guide buffer delay

endfunction

