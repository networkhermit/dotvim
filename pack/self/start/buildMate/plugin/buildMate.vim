" ============================================================================
" File:        plugin/buildMate.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("g:loaded_buildMate") || &compatible
    finish
endif
let g:loaded_buildMate = v:true
