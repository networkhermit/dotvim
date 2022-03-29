" ============================================================================
" File:        ftplugin/python.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_python")
    finish
endif

let b:FORMATTER = []
eval b:FORMATTER->add("black --quiet -")

let b:BUILD_CMD = "python3 -d -W:all -B %:S"

let b:build_filetype_python = v:true
