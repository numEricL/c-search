if !exists('g:CSearch_v_map')
    let g:CSearch_v_map = '//'
endif

execute 'vnoremap <silent>'.g:CSearch_v_map.' :<c-u>call CSearch()<bar> set hlsearch <cr>'

function CSearch() abort
    let l:reg=getreg('"')
    let l:regtype=getregtype('"')
    normal! gv""y
    let @/ = @"

    " ignore ' \ ' (ignore line continuation)
    let l:space = escape('\_s', '\')
    let l:spaces = l:space.'\\*\\\\\\*'.l:space.'\\*'
    let l:surround_space = l:space.'&'.l:space
    let @/ = substitute(@/, '\_s\zs\\\ze\_s', '', 'g')

    let @/ = escape(@/, '\')
    let l:single = escape(';,(){}[]<>', ']')
    let @/=substitute(@/, '\V\['.l:single.']', l:surround_space, 'g')
    let l:multi = escape('+-*/%=!&|:=','-')
    let @/ = substitute(@/, '\V\['.l:multi.']\+', l:surround_space,'g')

    " cleanup
    let @/=substitute(@/, '\V\_s\+', l:space, 'g')
    let @/=substitute(@/, '\V\%('.l:space.'\)\+', l:space, 'g')
    let @/=substitute(@/, '\V\^'.l:space.'\|'.l:space.'\$','', 'g')
    let @/=substitute(@/, '\V'.l:space, l:spaces, 'g')
    let @/='\V'.@/
    call histadd("search", escape(@/, ''))
    call setreg('"', l:reg, l:regtype)
endfunction
