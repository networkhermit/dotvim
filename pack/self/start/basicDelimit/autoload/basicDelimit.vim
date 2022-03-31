" ============================================================================
" File:        autoload/basicDelimit.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Basic delimiter auto-completion.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

" Initialize Defaults {{{

let s:Parens     = ["{}", "[]", "()"]
let s:Quotes     = ['""', "''", "``"]
let s:Delimiters = s:Parens + s:Quotes

" }}}

function! basicDelimit#TypingOpeningParen(keystroke) abort " {{{
    if     a:keystroke == '{'
        return "{}\<C-G>U\<Left>"
    elseif a:keystroke == '['
        return "[]\<C-G>U\<Left>"
    elseif a:keystroke == '('
        return "()\<C-G>U\<Left>"
    endif
endfunction " }}}

function! basicDelimit#TypingClosingParen(keystroke) abort " {{{
    let l:next_char = strpart(getline('.'), col('.') - 1, 1)

    if l:next_char == a:keystroke
        return "\<C-G>U\<Right>"
    endif

    return a:keystroke
endfunction " }}}

function! basicDelimit#TypingQuote(keystroke) abort " {{{
    let l:next_char = strpart(getline('.'), col('.') - 1, 1)

    if l:next_char == a:keystroke
        return "\<C-G>U\<Right>"
    endif

    return a:keystroke .. a:keystroke .. "\<C-G>U\<Left>"
endfunction " }}}

function! basicDelimit#TypingBackSpace() abort " {{{
    let l:surroundings = strpart(getline('.'), col('.') - 2, 2)

    for delimiter in s:Delimiters
        if l:surroundings == delimiter
            return "\<Delete>\<BS>"
        endif
    endfor

    return "\<BS>"
endfunction " }}}

function! basicDelimit#TypingCarriageReturn() abort " {{{
    let l:surroundings = strpart(getline('.'), col('.') - 2, 2)

    for delimiter in s:Parens
        if l:surroundings == delimiter
            return "\<CR>\<Esc>O"
        endif
    endfor

    return "\<CR>"
endfunction " }}}
