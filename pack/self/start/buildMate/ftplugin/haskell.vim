" ============================================================================
" File:        ftplugin/haskell.vim
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
eval b:build['fmt']->add(['stylish-haskell'])
eval b:build['fmt']->add(['ormolu'])

let b:build['cmd'] = 'ghc -O0 -Wall -o %:t:r:S %:S && ./%:t:r:S'

let b:build['post_hook'] = []
eval b:build['post_hook']->add('call delete(expand("#:t:r"))')
eval b:build['post_hook']->add('call delete(expand("#:t:r") .. ".hi")')
eval b:build['post_hook']->add('call delete(expand("#:t:r") .. ".o")')

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
