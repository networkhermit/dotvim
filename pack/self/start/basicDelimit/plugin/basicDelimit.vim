" ============================================================================
" File:        plugin/basicDelimit.vim
" Version:     1.0
" LICENSE:     MIT
" Modified:    2014-10-24
" Description: Basic delimiter auto-completion.
" Maintainer:  vac <vac@bikeshed.dev>
" ============================================================================

scriptencoding utf-8

if exists("g:loaded_basicDelimit") || &compatible
    finish
endif
let g:loaded_basicDelimit = v:true

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

function! basicDelimit#Init() abort " {{{
    if exists("b:basicDelimit_enabled")
        return
    endif

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

    call s:LoadMapping()

    let b:basicDelimit_enabled = v:true
endfunction " }}}

function! basicDelimit#Toggle() abort " {{{
    if b:basicDelimit_enabled
        call s:DropMapping()
        let b:basicDelimit_enabled = v:false
    else
        call s:LoadMapping()
        let b:basicDelimit_enabled = v:true
    endif
endfunction " }}}

" Autocommand {{{

autocmd FileType c          call basicDelimit#Init()
autocmd FileType cpp        call basicDelimit#Init()
autocmd FileType go         call basicDelimit#Init()
autocmd FileType haskell    call basicDelimit#Init()
autocmd FileType java       call basicDelimit#Init()
autocmd FileType javascript call basicDelimit#Init()
autocmd FileType lisp       call basicDelimit#Init()
autocmd FileType ocaml      call basicDelimit#Init()
autocmd FileType php        call basicDelimit#Init()
autocmd FileType python     call basicDelimit#Init()
autocmd FileType ruby       call basicDelimit#Init()
autocmd FileType rust       call basicDelimit#Init()
autocmd FileType sh         call basicDelimit#Init()
autocmd FileType vim        call basicDelimit#Init()

" }}}

command! BasicDelimitToggle call basicDelimit#Toggle() | echo
