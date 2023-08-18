function! interdental#changeListener(bufnr, start, end, added, changes)
  call interdental#setIndentGuides(a:start, a:end)
endfunction


function! interdental#toggle(...)
  if a:0 ? a:1 : &listchars !~ 'leadmultispace'
    execute 'setlocal listchars+=leadmultispace:'.escape(g:leadmultispace, ' ')
    call interdental#setIndentGuides()
  else
    execute 'setlocal listchars-=leadmultispace:'.escape(g:leadmultispace, ' ')
    call prop_remove({'type': 'interdental'}, 1, line('$'))
  endif
endfunction


function! interdental#setIndentGuides(...)
  if !exists('g:leadmultispace') | return | endif

  if a:0
    let [start, end] = [a:1, a:2]
  else
    let [start, end] = [1, line('$')]
  endif

  call prop_remove({'type': 'interdental'}, start, end)

  for linenr in range(start, end)
    if empty(getline(linenr))
      call s:setIndentGuide(linenr)
    endif
  endfor
endfunction


function! s:setIndentGuide(linenr)
  let [firstline, lastline] = [1, line('$')]

  let offset = 1
  while a:linenr - offset >= firstline && empty(getline(a:linenr - offset))
    let offset += 1
  endwhile
  let prev_indent = indent(a:linenr - offset)

  let offset = 1
  while a:linenr + offset <= lastline && empty(getline(a:linenr + offset))
    let offset += 1
  endwhile
  let next_indent = indent(a:linenr + offset)

  if prev_indent < next_indent
    let len = prev_indent + 1
  elseif prev_indent > next_indent
    let len = next_indent + 1
  else
    " find indent containing previous indent
    let offset = 1
    while a:linenr - offset >= firstline && (
          \   empty(getline(a:linenr - offset)) ||
          \   indent(a:linenr - offset) >= prev_indent
          \ )
      let offset +=1
    endwhile
    let len = indent(a:linenr - offset) + 1
  endif

  let guide = strpart(g:leadmultispace, 0, len, v:true)
  call prop_add(a:linenr, 1, {'type': 'interdental', 'text': guide})
endfunction

