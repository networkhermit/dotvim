" ============================================================================
" File:        plugin/buildMate.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists('g:loaded_build_mate') || &compatible
    finish
endif
let g:loaded_build_mate = v:true

if !exists('g:build_mate_format_disabled_filetypes')
    let g:build_mate_format_disabled_filetypes = []
endif

command! BuildMateFormatToggle call buildMate#FormatToggle() | echo
