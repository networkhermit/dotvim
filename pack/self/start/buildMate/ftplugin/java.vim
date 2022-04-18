" ============================================================================
" File:        ftplugin/java.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Simple build automation.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8

let b:build = {}

let b:build['fmt'] = []
eval b:build['fmt']->add(['unset', '_JAVA_OPTIONS;', 'java', '-jar', '/usr/local/share/java/google-java-format.jar', '-'])

let b:build['cmd'] = 'unset _JAVA_OPTIONS; javac -d local_build -g -deprecation -Werror -Xlint:all,-path %:S && java -cp local_build -ea %:t:r:S'

let b:build['post_hook'] = []
eval b:build['post_hook']->add('call delete("local_build", "rf")')

if exists('g:loaded_basic_delimit')
    BasicDelimitBufferEnable
endif
