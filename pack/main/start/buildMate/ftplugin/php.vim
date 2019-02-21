" ============================================================================
" File:        ftplugin/php.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Automation of simple build process.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if exists("b:build_filetype_php")
    finish
endif

let b:BUILD_CMD = "php -e %"

let b:build_filetype_php = v:true
