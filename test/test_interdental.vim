function SetUp()
  set listchars+=leadmultispace:1234567890
  edit fixture.rb
endfunction

function TearDown()
  bdelete!
endfunction


function Test_bufenter()
  let actual = prop_list(1, {'end_lnum': -1})
  call assert_equal(7, len(actual))
  call Log(actual)

  let expected = [
        \ {'lnum':  3, 'length': 3},
        \ {'lnum':  5, 'length': 3},
        \ {'lnum':  7, 'length': 5},
        \ {'lnum':  9, 'length': 7},
        \ {'lnum': 13, 'length': 7},
        \ {'lnum': 15, 'length': 5},
        \ {'lnum': 17, 'length': 3}
        \ ]

  for i in range(len(expected))
    let [e, a] = [expected[i], actual[i]]
    call assert_equal(e.lnum,   a.lnum)
    call assert_equal(1,        a.col)
    call assert_equal(e.length, a.length)
  endfor

endfunction
