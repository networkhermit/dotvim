" ============================================================================
" File:        plugin/buildMate.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

scriptencoding utf-8

if exists("g:buildMate_loaded") || &compatible
    finish
endif
let g:buildMate_loaded = v:true
