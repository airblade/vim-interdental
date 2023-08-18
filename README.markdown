# vim-interdental

Indent guides that span empty lines.


### Quick start

1. Set `g:leadmultispace` to your indent guide characters – without escaping spaces.  For example:

    ```vim
    let g:leadmultispace = '  ⋮ · ⋮ · ⋮ · ⋮ · ⋮ · ⋮ · ⋮ · ⋮'
    ```

    (Don't set `'listchars+=leadmultispace:...'`.  The plugin manages it for you.)

2. Set up a map to toggle your indent guides.  For example:

    ```vim
    nmap <Leader>ti <Plug>(InterdentalToggle)
    ```

3. Set the filetypes for which you want indent guides by default.  For example:

    ```vim
    autocmd FileType ruby,html call interdental#toggle(1)
    ```


### Description

The built-in option `'lcs-leadmultispace'` is perfect for indent guides.  It is one or more characters that are shown cyclically when a line has leading spaces.

For example, I like:

- indent guides every two characters;
- alternating two different characters to help distinguish the guides;
- not having a guide in column 1.

This is how to set it up.  Note that spaces have to be escaped.

```vim
setlocal listchars+=leadmultispace:\ \ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮
```

And here is what it looks like:

![Intermittent indent guides](./before.png?raw=true)

The problem is that empty lines don't have any leading spaces, so they don't get indent guides.

This plugin uses virtual text to display the indent guides on empty lines.

```diff
- setlocal listchars+=leadmultispace:\ \ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮\ ·\ ⋮
+ let g:leadmultispace = '  ⋮ · ⋮ · ⋮ · ⋮ · ⋮ · ⋮ · ⋮ · ⋮'
```

Behold the unbroken indent guides!

![Continuous indent guides](./after.png?raw=true)


### Intellectual property

Copyright Andrew Stewart, AirBlade Software Ltd.  Released under the MIT licence.
