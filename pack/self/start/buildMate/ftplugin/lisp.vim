" ============================================================================
" File:        ftplugin/lisp.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if exists("b:build_filetype_lisp")
    finish
endif

let s:BUILD_OPT = " --noinform --non-interactive --no-sysinit "
let b:BUILD_CMD = "sbcl ". s:BUILD_OPT . "--load % --eval \"(when (fboundp 'main) (main))\""
unlet s:BUILD_OPT

let b:build_filetype_lisp = v:true
