" ============================================================================
" File:        ftplugin/python.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Automation of simple build process.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if exists("b:build_filetype_python")
    finish
endif

let b:BUILD_CMD = "python3 -d -W:all -B %"

let b:build_filetype_python = v:true
