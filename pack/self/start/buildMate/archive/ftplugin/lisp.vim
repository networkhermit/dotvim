" ============================================================================
" File:        ftplugin/lisp.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8

let b:build = {}

let s:build_opt = ' --noinform --non-interactive --no-sysinit '
let b:build['cmd'] = 'sbcl ' .. s:build_opt .. '--load %:S --eval "(when (fboundp ''main) (main))"'
unlet s:build_opt

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
