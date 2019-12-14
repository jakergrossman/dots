function! autocmds#blur_statusline() abort
    " default blurred statusline (buffer num: filename)
    let l:blurred='%{statusline#gutterpadding(0)}'
    let l:blurred.='\ ' " space
    let l:blurred.='\ ' " space
    let l:blurred.='\ ' " space
    let l:blurred.='%<' " truncation point
    let l:blurred.='%f' " file name
    let l:blurred.='%=' " split left/right halves (make background cover whole)
    call s:update_statusline(l:blurred)
endfunction

function! autocmds#focus_statusline() abort
    " `setlocal statusline=` will revert to global statusline setting
    call s:update_statusline('')
endfunction

function! s:update_statusline(line) abort
    execute 'setlocal statusline=' . a:line
endfunction
    
