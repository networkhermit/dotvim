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

let b:BUILD_CMD = "unset _JAVA_OPTIONS; javac -d local_build -g -deprecation -Werror -Xlint:all,-path %:S && java -cp local_build -ea %:t:r:S"

let b:POST_BUILD_ACTION = []
eval b:POST_BUILD_ACTION->add('call delete("local_build", "rf")')

let b:build_filetype_java = v:true
