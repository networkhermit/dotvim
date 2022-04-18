" ============================================================================
" File:        ftplugin/rust.vim
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
eval b:build['fmt']->add(['rustfmt'])

let b:build['cmd'] = 'rustc -C opt-level=0 -g %:S && ./%:t:r:S'

let b:build['post_hook'] = []
eval b:build['post_hook']->add('call delete(expand("#:t:r"))')

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
