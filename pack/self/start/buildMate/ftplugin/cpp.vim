" ============================================================================
" File:        ftplugin/cpp.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_cpp")
    finish
endif

let b:BUILD_OPT = " -O0 -g3 -Wall -Werror -std=c++20 -x c++ -o %:t:r:S "
let b:BUILD_CMD = "g++" .. b:BUILD_OPT .. "%:S && clang++" .. b:BUILD_OPT .. "%:S && ./%:t:r:S"
unlet b:BUILD_OPT

let b:POST_BUILD_ACTION = []
eval b:POST_BUILD_ACTION->add('call delete(expand("#:t:r"))')

let b:build_filetype_cpp = v:true
