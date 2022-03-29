" ============================================================================
" File:        ftplugin/go.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_go")
    finish
endif

let b:FORMATTER = []
eval b:FORMATTER->add("gofmt")

let b:BUILD_CMD = "go run %:S"

let b:POST_BUILD_ACTION = []
eval b:POST_BUILD_ACTION->add('call system("go clean -cache")')

let b:build_filetype_go = v:true
