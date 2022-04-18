" ============================================================================
" File:        plugin/basicDelimit.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Basic delimiter auto-completion.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists('g:loaded_basic_delimit') || &compatible
    finish
endif
let g:loaded_basic_delimit = v:true

" Partial Mapping {{{

inoremap <expr> <Plug>basicDelimit{    basicDelimit#TypingOpeningParen('{')
inoremap <expr> <Plug>basicDelimit}    basicDelimit#TypingClosingParen('}')
inoremap <expr> <Plug>basicDelimit[    basicDelimit#TypingOpeningParen('[')
inoremap <expr> <Plug>basicDelimit]    basicDelimit#TypingClosingParen(']')
inoremap <expr> <Plug>basicDelimit(    basicDelimit#TypingOpeningParen('(')
inoremap <expr> <Plug>basicDelimit)    basicDelimit#TypingClosingParen(')')
inoremap <expr> <Plug>basicDelimit"    basicDelimit#TypingQuote('"')
inoremap <expr> <Plug>basicDelimit'    basicDelimit#TypingQuote("'")
inoremap <expr> <Plug>basicDelimit`    basicDelimit#TypingQuote('`')
inoremap <expr> <Plug>basicDelimit<BS> basicDelimit#TypingBackSpace()
inoremap <expr> <Plug>basicDelimit<CR> basicDelimit#TypingCarriageReturn()

" }}}

command! BasicDelimitBufferDisable call basicDelimit#BufferDisable() | echo
command! BasicDelimitBufferEnable call basicDelimit#BufferEnable() | echo
command! BasicDelimitBufferToggle call basicDelimit#BufferToggle() | echo
