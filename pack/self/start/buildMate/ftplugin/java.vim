" ============================================================================
" File:        ftplugin/java.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("b:build_filetype_java")
    finish
endif

let b:BUILD_CMD = "unset _JAVA_OPTIONS; javac -d local_build -g -deprecation -Werror -Xlint:all,-path % && java -cp local_build -ea %<"

let b:POST_ACTION = []
call add(b:POST_ACTION, "call delete(\"local_build\", \"rf\")")

let b:build_filetype_java = v:true
