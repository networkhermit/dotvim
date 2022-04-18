" ============================================================================
" File:        autoload/basicDelimit.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Basic delimiter auto-completion.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

" Initialize Token {{{

let s:Parens = ['{}', '[]', '()']
let s:Quotes = ['""', "''", '``']
let s:Delimiters = s:Parens + s:Quotes

" }}}

function! basicDelimit#TypingOpeningParen(keystroke) abort " {{{
    if a:keystroke is# '{'
        return "{}\<C-G>U\<Left>"
    elseif a:keystroke is# '['
        return "[]\<C-G>U\<Left>"
    elseif a:keystroke is# '('
        return "()\<C-G>U\<Left>"
    endif
endfunction " }}}

function! basicDelimit#TypingClosingParen(keystroke) abort " {{{
    let l:next_char = strpart(getline('.'), col('.') - 1, 1)

    if l:next_char is# a:keystroke
        return "\<C-G>U\<Right>"
    endif

    return a:keystroke
endfunction " }}}

function! basicDelimit#TypingQuote(keystroke) abort " {{{
    let l:next_char = strpart(getline('.'), col('.') - 1, 1)

    if l:next_char is# a:keystroke
        return "\<C-G>U\<Right>"
    endif

    return a:keystroke .. a:keystroke .. "\<C-G>U\<Left>"
endfunction " }}}

function! basicDelimit#TypingBackSpace() abort " {{{
    let l:surroundings = strpart(getline('.'), col('.') - 2, 2)

    for delimiter in s:Delimiters
        if l:surroundings is# delimiter
            return "\<Delete>\<BS>"
        endif
    endfor

    return "\<BS>"
endfunction " }}}

function! basicDelimit#TypingCarriageReturn() abort " {{{
    let l:surroundings = strpart(getline('.'), col('.') - 2, 2)

    for delimiter in s:Parens
        if l:surroundings is# delimiter
            return "\<CR>\<Esc>O"
        endif
    endfor

    return "\<CR>"
endfunction " }}}

function! s:LoadMapping() abort " {{{
    imap   <buffer> {    <Plug>basicDelimit{
    imap   <buffer> }    <Plug>basicDelimit}
    imap   <buffer> [    <Plug>basicDelimit[
    imap   <buffer> ]    <Plug>basicDelimit]
    imap   <buffer> (    <Plug>basicDelimit(
    imap   <buffer> )    <Plug>basicDelimit)
    imap   <buffer> "    <Plug>basicDelimit"
    imap   <buffer> '    <Plug>basicDelimit'
    imap   <buffer> `    <Plug>basicDelimit`
    imap   <buffer> <BS> <Plug>basicDelimit<BS>
    imap   <buffer> <CR> <Plug>basicDelimit<CR>
endfunction " }}}

function! s:DropMapping() abort " {{{
    iunmap <buffer> {
    iunmap <buffer> }
    iunmap <buffer> [
    iunmap <buffer> ]
    iunmap <buffer> (
    iunmap <buffer> )
    iunmap <buffer> "
    iunmap <buffer> '
    iunmap <buffer> `
    iunmap <buffer> <BS>
    iunmap <buffer> <CR>
endfunction " }}}

function! basicDelimit#BufferDisable() abort " {{{
    call s:DropMapping()
    let b:basic_delimit_enabled = v:false
endfunction " }}}

function! basicDelimit#BufferEnable() abort " {{{
    call s:LoadMapping()
    let b:basic_delimit_enabled = v:true
endfunction " }}}

function! basicDelimit#BufferToggle() abort " {{{
    if get(b:, 'basic_delimit_enabled', v:false)
        call basicDelimit#BufferDisable()
    else
        call basicDelimit#BufferEnable()
    endif
endfunction " }}}
