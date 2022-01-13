" ============================================================================
" File:        ftplugin/haskell.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_haskell")
    finish
endif

let b:BUILD_CMD = "ghc -O0 -Wall -o %< % && ./%<"

let b:POST_ACTION = []
call add(b:POST_ACTION, "call delete(expand(\"%<\"))")
call add(b:POST_ACTION, "call delete(expand(\"%<\") . \".hi\")")
call add(b:POST_ACTION, "call delete(expand(\"%<\") . \".o\")")

let b:build_filetype_haskell = v:true
