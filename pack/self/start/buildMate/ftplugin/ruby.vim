" ============================================================================
" File:        ftplugin/ruby.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_ruby")
    finish
endif

let b:BUILD_CMD = "ruby -w %:S"

let b:build_filetype_ruby = v:true
