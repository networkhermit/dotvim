" ============================================================================
" File:        ftplugin/ocaml.vim
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
eval b:build['fmt']->add(['ocamlformat', '--name', 'lang.ml', '-'])

let b:build['cmd'] = 'ocamlopt -g -o %:t:r:S %:S && ./%:t:r:S'

let b:build['post_hook'] = []
eval b:build['post_hook']->add('call delete(expand("#:t:r"))')
eval b:build['post_hook']->add('call delete(expand("#:t:r") .. ".cmi")')
eval b:build['post_hook']->add('call delete(expand("#:t:r") .. ".cmx")')
eval b:build['post_hook']->add('call delete(expand("#:t:r") .. ".o")')

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
