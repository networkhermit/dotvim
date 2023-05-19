" ============================================================================
" File:        ftplugin/ruby.vim
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
eval b:build['fmt']->add(['standardrb', '--fix', '--fail-level', 'warning', '--stderr', '--stdin', 'lang.rb', '2>/dev/null'])

let b:build['cmd'] = 'ruby -w %:S'

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
