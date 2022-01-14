" ============================================================================
" File:        ftplugin/cpp.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_cpp")
    finish
endif

let s:BUILD_OPT = " -O0 -g3 -Wall -Werror -std=c++20 -x c++ -o %< "
let b:BUILD_CMD = "g++" . s:BUILD_OPT . "% && clang++" . s:BUILD_OPT ."% && ./%<"
unlet s:BUILD_OPT

let b:POST_ACTION = []
call add(b:POST_ACTION, "call delete(expand(\"%<\"))")

let b:build_filetype_cpp = v:true
