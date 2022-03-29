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

let b:BUILD_CMD = "ocamlopt -g -o %:r:S %:S && ./%:r:S"

let b:POST_BUILD_ACTION = []
eval b:POST_BUILD_ACTION->add('call delete(expand("#:r"))')
eval b:POST_BUILD_ACTION->add('call delete(expand("#:r") .. ".cmi")')
eval b:POST_BUILD_ACTION->add('call delete(expand("#:r") .. ".cmx")')
eval b:POST_BUILD_ACTION->add('call delete(expand("#:r") .. ".o")')

let b:build_filetype_ocaml = v:true
