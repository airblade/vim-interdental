function SetUp()
  let g:leadmultispace = '1234567890'
  autocmd FileType ruby call interdental#toggle(1)
  edit fixture.rb
endfunction

function TearDown()
  bdelete!
endfunction


function Test_bufenter()
  let actual = prop_list(1, {'end_lnum': -1})
  call assert_equal(7, len(actual))

  let expected = [
        \ {'lnum':  3, 'length': 3, 'text': '123'},
        \ {'lnum':  5, 'length': 3, 'text': '123'},
        \ {'lnum':  7, 'length': 5, 'text': '12345'},
        \ {'lnum':  9, 'length': 7, 'text': '1234567'},
        \ {'lnum': 13, 'length': 7, 'text': '1234567'},
        \ {'lnum': 15, 'length': 5, 'text': '12345'},
        \ {'lnum': 17, 'length': 3, 'text': '123'}
        \ ]

  for i in range(len(expected))
    let [e, a] = [expected[i], actual[i]]
    call assert_equal(e.lnum,   a.lnum)
    call assert_equal(1,        a.col)
    call assert_equal(e.length, a.length)
    if has('patch-9.0.1762')
      call assert_equal(e.text, a.text)
    endif
  endfor

endfunction
