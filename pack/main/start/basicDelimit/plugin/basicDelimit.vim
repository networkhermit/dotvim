" ============================================================================
" File:        plugin/basicDelimit.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Basic auto-completion for delimiters.
" Maintainer:  vac <vac@muse.sh>
" ============================================================================

if exists("g:basicDelimit_loaded") || &compatible
    finish
endif
let g:basicDelimit_loaded = v:true

function! s:LoadMapping() " {{{
    imap   <buffer> <silent> {    <Plug>basicDelimit{
    imap   <buffer> <silent> }    <Plug>basicDelimit}
    imap   <buffer> <silent> [    <Plug>basicDelimit[
    imap   <buffer> <silent> ]    <Plug>basicDelimit]
    imap   <buffer> <silent> (    <Plug>basicDelimit(
    imap   <buffer> <silent> )    <Plug>basicDelimit)
    imap   <buffer> <silent> "    <Plug>basicDelimit"
    imap   <buffer> <silent> '    <Plug>basicDelimit'
    imap   <buffer> <silent> `    <Plug>basicDelimit`
    imap   <buffer> <silent> <BS> <Plug>basicDelimit<BS>
    imap   <buffer> <silent> <CR> <Plug>basicDelimit<CR>
endfunction " }}}

function! s:DropMapping() " {{{
    iunmap <buffer> <silent> {
    iunmap <buffer> <silent> }
    iunmap <buffer> <silent> [
    iunmap <buffer> <silent> ]
    iunmap <buffer> <silent> (
    iunmap <buffer> <silent> )
    iunmap <buffer> <silent> "
    iunmap <buffer> <silent> '
    iunmap <buffer> <silent> `
    iunmap <buffer> <silent> <BS>
    iunmap <buffer> <silent> <CR>
endfunction " }}}

function! basicDelimit#Init() " {{{
    if exists("b:basicDelimit_enabled")
        return
    endif

    inoremap <silent> <expr> <Plug>basicDelimit{    basicDelimit#TypingOpeningParen('{')
    inoremap <silent> <expr> <Plug>basicDelimit}    basicDelimit#TypingClosingParen('}')
    inoremap <silent> <expr> <Plug>basicDelimit[    basicDelimit#TypingOpeningParen('[')
    inoremap <silent> <expr> <Plug>basicDelimit]    basicDelimit#TypingClosingParen(']')
    inoremap <silent> <expr> <Plug>basicDelimit(    basicDelimit#TypingOpeningParen('(')
    inoremap <silent> <expr> <Plug>basicDelimit)    basicDelimit#TypingClosingParen(')')
    inoremap <silent> <expr> <Plug>basicDelimit"    basicDelimit#TypingQuote('"')
    inoremap <silent> <expr> <Plug>basicDelimit'    basicDelimit#TypingQuote("'")
    inoremap <silent> <expr> <Plug>basicDelimit`    basicDelimit#TypingQuote('`')
    inoremap <silent> <expr> <Plug>basicDelimit<BS> basicDelimit#TypingBackSpace()
    inoremap <silent> <expr> <Plug>basicDelimit<CR> basicDelimit#TypingCarriageReturn()

    silent call s:LoadMapping()

    let b:basicDelimit_enabled = v:true
endfunction " }}}

function! basicDelimit#Toggle() " {{{
    if b:basicDelimit_enabled
        silent call s:DropMapping()
        let b:basicDelimit_enabled = v:false
    else
        silent call s:LoadMapping()
        let b:basicDelimit_enabled = v:true
    endif
endfunction " }}}

" Autocommand {{{

autocmd FileType c          silent call basicDelimit#Init()
autocmd FileType cpp        silent call basicDelimit#Init()
autocmd FileType go         silent call basicDelimit#Init()
autocmd FileType java       silent call basicDelimit#Init()
autocmd FileType javascript silent call basicDelimit#Init()
autocmd FileType lisp       silent call basicDelimit#Init()
autocmd FileType ocaml      silent call basicDelimit#Init()
autocmd FileType php        silent call basicDelimit#Init()
autocmd FileType python     silent call basicDelimit#Init()
autocmd FileType ruby       silent call basicDelimit#Init()
autocmd FileType rust       silent call basicDelimit#Init()
autocmd FileType sh         silent call basicDelimit#Init()
autocmd FileType vim        silent call basicDelimit#Init()

" }}}

command! ToggleBasicDelimit call basicDelimit#Toggle() | echo
