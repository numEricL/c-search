if !exists('g:CSearch_v_map')
    let g:CSearch_v_map = '//'
endif
execute 'vnoremap <silent>'.g:CSearch_v_map.' :<c-u>call CSearch()<bar> set hlsearch <cr>'

function CSearch() abort
    let l:reg=getreg('"')
    let l:regtype=getregtype('"')
    normal! gv""y
    let @/ = @"

    let l:space = escape('\_s', '\')
    let l:spaces = l:space.'\\*\\\\\\*'.l:space.'\\*'   " this pattern allows matching
    let l:surround_space = l:space.'&'.l:space          "      macro line continuation

    " ignore ' \ ' (line continuation)
    let @/ = substitute(@/, '\_s\zs\\\ze\_s', '', 'g')

    let @/ = escape(@/, '\')

    " separate brackets
    let l:single = ';,(){}[]<>'
    let l:e_single = escape(l:single, '-]')
    let @/=substitute(@/, '\V\['.l:e_single.']', l:surround_space, 'g')

    " separate operators with concatenated symbols e.g. += == !=
    let l:multi = '+-*/%=!&|^:'
    let l:e_multi = escape(l:multi,'-]')
    let @/ = substitute(@/, '\V\['.l:e_multi.']\+', l:surround_space,'g')

    " separate some unary operators from concatenated operators e.g. *p1+*p2
    let l:unaries = ['*','-']
    for l:unary in l:unaries
        let l:left_concat = substitute(l:multi, '\V'.l:unary, '', 'g')
        let l:e_left_concat = escape(l:left_concat, '-]')
        let @/ = substitute(@/, '\V\['.l:e_left_concat.']\zs'.l:unary, l:space.'&','g')
    endfor

    " necessary for vim searching
    let @/ = escape(@/, '/')

    " cleanup
    let @/=substitute(@/, '\V\_s\+', l:space, 'g')
    let @/=substitute(@/, '\V\%('.l:space.'\)\+', l:space, 'g')
    let @/=substitute(@/, '\V\^'.l:space.'\|'.l:space.'\$','', 'g')
    let @/=substitute(@/, '\V'.l:space, l:spaces, 'g')
    let @/='\V'.@/
    call histadd("search", escape(@/, ''))
    call setreg('"', l:reg, l:regtype)
endfunction
