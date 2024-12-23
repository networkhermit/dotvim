" ============================================================================
" File:        ftplugin/go.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8

let b:build = {}

let b:build['fmt'] = []
eval b:build['fmt']->add(['goimports'])
eval b:build['fmt']->add(['gofmt', '-s'])

let b:build['cmd'] = 'go run %:S'

let b:build['post_hook'] = []
eval b:build['post_hook']->add('call system(''go clean -cache'')')

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
