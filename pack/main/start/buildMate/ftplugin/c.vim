" ============================================================================
" File:        ftplugin/c.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if &filetype == "cpp"
    finish
endif

if exists("b:build_filetype_c")
    finish
endif

let s:BUILD_OPT = " -O0 -g3 -Wall -Werror -std=c11 -x c -o %< "
let b:BUILD_CMD = "gcc" . s:BUILD_OPT . "% -lm && clang" . s:BUILD_OPT ."% -lm && ./%<"
unlet s:BUILD_OPT

let b:POST_ACTION = []
call add(b:POST_ACTION, "call delete(expand(\"%<\"))")

let b:build_filetype_c = v:true
