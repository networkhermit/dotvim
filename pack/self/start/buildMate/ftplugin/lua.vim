" ============================================================================
" File:        ftplugin/lua.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

setlocal noexpandtab shiftwidth=2 softtabstop=2 tabstop=8

let b:build = {}

let b:build['fmt'] = []
eval b:build['fmt']->add(['stylua', '--search-parent-directories', '-'])

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
