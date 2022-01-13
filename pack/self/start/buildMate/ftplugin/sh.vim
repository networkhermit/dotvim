" ============================================================================
" File:        ftplugin/sh.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_sh")
    finish
endif

let b:BUILD_CMD = "shellcheck % && bash %"

let b:build_filetype_sh = v:true
