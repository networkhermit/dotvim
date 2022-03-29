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

let b:FORMATTER = []
eval b:FORMATTER->add("rustfmt")

let b:BUILD_CMD = "rustc -C opt-level=0 -g %:S && ./%:r:S"

let b:POST_BUILD_ACTION = []
eval b:POST_BUILD_ACTION->add('call delete(expand("#:r"))')

let b:build_filetype_rust = v:true
