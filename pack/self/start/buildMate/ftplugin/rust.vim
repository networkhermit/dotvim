" ============================================================================
" File:        ftplugin/rust.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_rust")
    finish
endif

let b:BUILD_CMD = "rustc -C opt-level=0 -g % && ./%<"

let b:POST_ACTION = []
call add(b:POST_ACTION, "call delete(expand(\"%<\"))")

let b:build_filetype_rust = v:true
