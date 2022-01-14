" ============================================================================
" File:        ftplugin/ocaml.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_ocaml")
    finish
endif

let b:BUILD_CMD = "ocamlopt -g -o %< % && ./%<"

let b:POST_ACTION = []
call add(b:POST_ACTION, "call delete(expand(\"%<\"))")
call add(b:POST_ACTION, "call delete(expand(\"%<\") . \".cmi\")")
call add(b:POST_ACTION, "call delete(expand(\"%<\") . \".cmx\")")
call add(b:POST_ACTION, "call delete(expand(\"%<\") . \".o\")")

let b:build_filetype_ocaml = v:true
