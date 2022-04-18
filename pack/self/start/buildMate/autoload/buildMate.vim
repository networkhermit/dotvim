" ============================================================================
" File:        autoload/buildMate.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

function! buildMate#Format() abort " {{{
    if !exists('b:build')
        return
    endif
    if get(g:, 'build_mate_format_disabled', v:false)
        return
    endif
    for l:fmt in get(b:build, 'fmt', [])
        try
            let l:temp = tempname()
            let l:stdout = systemlist('{ ' .. l:fmt->join() .. '; } 2>' .. l:temp, bufnr())
        finally
            let l:stderr = []
            if filereadable(l:temp)
                let l:stderr = readfile(l:temp)
                call delete(l:temp)
            endif
        endtry
        if v:shell_error || !empty(l:stderr)
            if v:shell_error is 127
                echohl WarningMsg
                echomsg 'formatter ' .. l:fmt[0] .. ' not found'
                echohl None
            else
                echohl ErrorMsg
                echomsg 'formatter ' .. l:fmt[0] .. ' failed with exit code ' .. v:shell_error .. ':'
                for l:line in empty(l:stderr) ? l:stdout : l:stderr
                    echomsg l:line
                endfor
                echohl None
            endif
            continue
        endif
        let l:before = line('$')
        let l:after = l:stdout->len()
        if l:before > l:after
            call deletebufline(bufname(), l:after, l:before)
        endif
        call setline(1, l:stdout)
    endfor
endfunction " }}}

function! s:ExecutePostHook(channel) abort " {{{
    for l:hook in get(getbufvar('#', 'build'), 'post_hook', [])
        execute l:hook
    endfor
endfunction " }}}

function! buildMate#Run() abort " {{{
    update
    if !exists('b:build["cmd"]')
        return
    endif
    call term_start(['/bin/bash', '-c' , expandcmd(b:build['cmd'])], {'close_cb': 's:ExecutePostHook'})
endfunction " }}}

function! buildMate#FormatToggle() abort " {{{
    if get(g:, 'build_mate_format_disabled', v:false)
        unlet! g:build_mate_format_disabled
    else
        let g:build_mate_format_disabled = v:true
    endif
endfunction " }}}
