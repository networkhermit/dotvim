" ============================================================================
" File:        ftplugin/cpp.vim
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
eval b:build['fmt']->add(['clang-format', '--assume-filename', 'lang.cpp', '--style', 'file'])

let s:build_opt = ' -O0 -g3 -Wall -Werror -std=c++20 -x c++ -o %:t:r:S '
let b:build['cmd'] = 'g++' .. s:build_opt .. '%:S && clang++' .. s:build_opt .. '%:S && ./%:t:r:S'
unlet s:build_opt

let b:build['post_hook'] = []
eval b:build['post_hook']->add('call delete(expand("#:t:r"))')

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
