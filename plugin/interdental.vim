if has('nvim')
  echoerr 'vim-interdental: neovim is not supported yet, sorry.'
  finish
endif

if !has('patch-9.0.0067')
  echoerr 'vim-interdental: requires virtual-text (vim 9.0.0067)'
  finish
endif

if !exists('*listener_add')
  echoerr 'vim-interdental: requires listener_add() (vim 8.1.1321)'
  finish
endif

if !has('patch-8.2.5066')
  echoerr 'vim-interdental: requires lcs-leadmultispace (vim 8.2.5066)'
  finish
endif



call prop_type_add('interdental', {'highlight': 'SpecialKey'})

autocmd BufReadPost * call listener_add('interdental#changeListener')

nnoremap <silent> <Plug>(InterdentalToggle) <Cmd>call interdental#toggle()<CR>
