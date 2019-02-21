" ============================================================================
" File:        autoload/buildMate.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Automation of simple build process.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

let s:GVIM = has("gui_running")

function! buildMate#start() " {{{
    silent update

    if s:GVIM
        echo "Who You Are Is Not Enough"
        return
    endif

    if exists("b:BUILD_CMD")
        execute "!clear && " . b:BUILD_CMD
    else
        return
    endif

    if exists("b:POST_ACTION")
        for action in b:POST_ACTION
            silent execute action
        endfor
    endif
endfunction " }}}
