" ============================================================================
" File:        ftplugin/go.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Automation of simple build process.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if exists("b:build_filetype_go")
    finish
endif

let b:BUILD_CMD = "go run %"

let b:POST_ACTION = []
call add(b:POST_ACTION, "!go clean -cache")

let b:build_filetype_go = v:true
