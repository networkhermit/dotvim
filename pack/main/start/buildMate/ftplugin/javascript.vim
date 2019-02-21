" ============================================================================
" File:        ftplugin/javascript.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Automation of simple build process.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if exists("b:build_filetype_javascript")
    finish
endif

let b:BUILD_CMD = "node --throw-deprecation --trace-warnings %"

let b:build_filetype_javascript = v:true
