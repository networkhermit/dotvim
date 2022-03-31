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
    if !exists("b:FORMATTER")
        return
    endif
    for action in b:FORMATTER
        let l:stdout = systemlist(action, bufnr())
        if v:shell_error != 0
            echoerr &filetype .. " formatter `" .. action .. "` failed with exit code " .. v:shell_error .. ": " .. l:stdout->string()
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

function! buildMate#Run() abort " {{{
    update

    if !has("terminal")
        return
    endif

    if !exists("b:BUILD_CMD")
        return
    endif

    let s:POST_BUILD_ACTION = []
    function! s:cleanUp(channel) abort
        for action in s:POST_BUILD_ACTION
            execute action
        endfor
    endfunction

    if exists("b:POST_BUILD_ACTION")
        let s:POST_BUILD_ACTION = b:POST_BUILD_ACTION
    endif

    call term_start(["/bin/bash", "-c" , expandcmd(b:BUILD_CMD)], {"close_cb": "s:cleanUp"})
endfunction " }}}
