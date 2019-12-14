function s:CheckColorScheme()
    if !has('termguicolors')
        let g:base16colorspace=256
    endif

    set background=dark
    colorscheme base16-default-dark

    " make EndOfBuffer region less obvious
    highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
endfunction

if v:progname !=# 'vi'
    if has('autocmd')
        augroup JakeAutocolor
            autocmd!
            autocmd FocusGained * call s:CheckColorScheme()
        augroup END
    endif

    call s:CheckColorScheme()
endif
