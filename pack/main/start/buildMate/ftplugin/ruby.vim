" ============================================================================
" File:        ftplugin/ruby.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Automation of simple build process.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if exists("b:build_filetype_ruby")
    finish
endif

let b:BUILD_CMD = "ruby -w %"

let b:build_filetype_ruby = v:true
