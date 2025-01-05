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
    if g:->get('build_mate_format_disabled', v:false)
        return
    endif
    if g:build_mate_format_disabled_filetypes->index(&filetype) >= 0
        return
    endif
    if line2byte(1) is -1
      return
    endif
    for l:fmt in b:build->get('fmt', [])
        if !executable(l:fmt[0])
            echohl WarningMsg
            echomsg 'formatter ' .. l:fmt[0] .. ' not found'
            echohl None
            continue
        endif
        try
            let l:temp = tempname()
            let l:stdout = systemlist(l:fmt->join() .. ' 2>' .. l:temp, bufnr())
            if has('win64')
                eval l:stdout->map({_, val -> val->trim("\r", 2)})
            endif
        finally
            let l:stderr = []
            if filereadable(l:temp)
                let l:stderr = readfile(l:temp)
                call delete(l:temp)
            endif
        endtry
        if v:shell_error || !empty(l:stderr)
            echohl ErrorMsg
            echomsg 'formatter ' .. l:fmt[0] .. ' failed with exit code ' .. v:shell_error .. ':'
            for l:line in empty(l:stderr) ? l:stdout : l:stderr
                echomsg l:line
            endfor
            echohl None
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
    for l:hook in getbufvar('#', 'build')->get('post_hook', [])
        execute l:hook
    endfor
endfunction " }}}

function! buildMate#Run() abort " {{{
    update
    if !exists('b:build["cmd"]')
        return
    endif
    if !has('nvim')
        call term_start(['/usr/bin/env', 'bash', '-c' , expandcmd(b:build['cmd'])], {'close_cb': 's:ExecutePostHook'})
    endif
endfunction " }}}

function! buildMate#FormatToggle() abort " {{{
    if g:->get('build_mate_format_disabled', v:false)
        unlet! g:build_mate_format_disabled
    else
        let g:build_mate_format_disabled = v:true
    endif
endfunction " }}}
