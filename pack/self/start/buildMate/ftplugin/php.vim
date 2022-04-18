" ============================================================================
" File:        ftplugin/php.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8

let b:build = {}

let b:build['fmt'] = []
eval b:build['fmt']->add(['phpcbf', '--standard=PSR12', '-', '||', '((', '$?', '==', '1', '))'])

let b:build['cmd'] = 'php -e %:S'

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
