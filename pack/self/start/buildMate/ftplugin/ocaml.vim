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

let b:BUILD_CMD = "ocamlopt -g -o %:t:r:S %:S && ./%:t:r:S"

let b:POST_BUILD_ACTION = []
eval b:POST_BUILD_ACTION->add('call delete(expand("#:t:r"))')
eval b:POST_BUILD_ACTION->add('call delete(expand("#:t:r") .. ".cmi")')
eval b:POST_BUILD_ACTION->add('call delete(expand("#:t:r") .. ".cmx")')
eval b:POST_BUILD_ACTION->add('call delete(expand("#:t:r") .. ".o")')

let b:build_filetype_ocaml = v:true
