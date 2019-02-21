" ============================================================================
" File:        ftplugin/sh.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Automation of simple build process.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if exists("b:build_filetype_sh")
    finish
endif

let b:BUILD_CMD = "shellcheck % && bash %"

let b:build_filetype_sh = v:true
