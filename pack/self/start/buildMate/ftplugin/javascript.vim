" ============================================================================
" File:        ftplugin/javascript.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8

let b:build = {}

let b:build['fmt'] = []
eval b:build['fmt']->add(['standard', '--fix', '--stdin'])

let b:build['cmd'] = 'node --throw-deprecation --trace-warnings %:S'

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
