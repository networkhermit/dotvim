"Kali Linux----------------------------------------------------------------
"-------------------------------Vi IMproved--------------------------------
"--------------------This is my Vim configuration file.--------------------

" PREFACE:  First Breath After Coma {{{

"                             Ode to a Nightingale
"                                  John Keats

" My heart aches, and a drowsy numbness pains
"   My sense, as though of hemlock I had drunk,
" Or emptied some dull opiate to the drains
"   One minute past, and Lethe-wards had sunk:
" ’Tis not through envy of thy happy lot,
"   But being too happy in thine happiness,—
"     That thou, light-winged Dryad of the trees,
"       In some melodious plot
"   Of beechen green, and shadows numberless,
"     Singest of summer in full-throated ease.

" }}}

" SECTION:  PRELUDE {{{

scriptencoding utf-8

syntax on
filetype plugin indent on

" }}}
" SECTION:  SYMBOL {{{

let s:LINUX = v:false
let s:MACOS = v:false
let s:TERMINAL = v:true
let s:WINDOWS = v:false

if has('gui_running')
    let s:TERMINAL = v:false
endif

if has('linux')
    let s:LINUX = v:true
elseif has('mac')
    let s:MACOS = v:true
elseif has('win64')
    let s:WINDOWS = v:true
endif

" }}}
" SECTION:  OPTION {{{
" SECTION:  TURN ON {{{

set autochdir
set autoindent
set autoread
set breakindent
set expandtab
set hidden
set hlsearch
set incsearch
set lazyredraw
set linebreak
set list
set ruler
set secure
set shiftround
set showcmd
set showmatch
set splitbelow
set splitright
set startofline
set ttimeout
set ttyfast
set wildmenu

" }}}
" SECTION:  TURN OFF {{{

set nobackup
set nofileignorecase
set nojoinspaces
set nomodeline
set noshowmode
set nospell
set noundofile

" }}}
" SECTION:  NUMBER {{{

set cmdwinheight=1
set foldnestmax=2
set helpheight=0
set history=256
set laststatus=2
set linespace=0
set matchtime=1
set previewheight=1
set pumheight=15
set report=0
set shiftwidth=4
set sidescroll=1
set softtabstop=4
set tabpagemax=50
set tabstop=8
set textwidth=80
set ttimeoutlen=50
set updatetime=15000
set winminheight=0
set winminwidth=0

" }}}
" SECTION:  STRING {{{

set backspace=indent,eol,start
set breakindentopt=sbr
set browsedir=buffer
set cinoptions=g0
set completeopt+=longest
set diffopt+=vertical,foldcolumn:0
set display=lastline
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,prc,taiwan,latin1
set fileformats=unix,dos
set fillchars=vert:│,fold:·,foldsep:│,eob:~
set foldmethod=syntax
set foldopen-=hor
set formatoptions=croqlmBj
set guioptions=c
set listchars=tab:⇥\ ,trail:␣,extends:›,precedes:‹,nbsp:⍽
set mouse=a
set nrformats=bin,hex
set shortmess=atToOFc
set showbreak=↪\ 
set spelllang=en_us,en_gb
set spellsuggest+=6
set switchbuf=uselast
set viminfo+=n~/.viminfo
set virtualedit=all
set wildmode=longest:full,full

" }}}
" }}}
" SECTION:  SCHEME {{{

if s:TERMINAL
    if !has('nvim')
        set ttymouse=sgr
        if &term is# 'tmux-256color'
            let &t_BE = "\<Esc>[?2004h"
            let &t_BD = "\<Esc>[?2004l"
            let &t_PS = "\<Esc>[200~"
            let &t_PE = "\<Esc>[201~"

            let &t_fe = "\<Esc>[?1004h"
            let &t_fd = "\<Esc>[?1004l"

            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
    endif

    set background=light
    colorscheme default

    if &t_Co >= 256
        highlight ColorColumn  NONE ctermbg=236
        highlight CursorLine   NONE ctermbg=237
        highlight CursorLineNr NONE ctermfg=11  cterm=bold
        highlight Folded       NONE ctermfg=245 cterm=bold
        highlight LineNr       NONE ctermfg=242
        highlight SignColumn   NONE
    endif
else
    if !has('nvim')
        if s:WINDOWS
            set renderoptions=type:directx
        endif
    endif

    set background=dark
    colorscheme nord

    let s:FONT_SIZE = empty($FONT_SIZE) ? 12 : $FONT_SIZE

    if s:LINUX
        let &guifont = 'Fira Code ' .. s:FONT_SIZE
    elseif s:MACOS || s:WINDOWS
        let &guifont = 'Fira Code:h' .. s:FONT_SIZE
    endif
endif

" }}}
" SECTION:  PLUGIN {{{

runtime ftplugin/man.vim

let g:netrw_dirhistmax = 0

" }}}
" SECTION:  FUNCTION {{{
" SECTION:  EntryHook {{{

function! s:EntryHook() abort
    for l:winid in gettabinfo(tabpagenr())[0]['windows']
        call win_execute(l:winid, 'setlocal colorcolumn= nocursorline norelativenumber')
        call win_execute(l:winid, 'let &l:number = winwidth(0) > &l:textwidth')
    endfor
    if winwidth(0) > &l:textwidth
        setlocal colorcolumn=+1 cursorline
    endif
    let &l:relativenumber = &g:relativenumber && &l:number
endfunction

" }}}
" SECTION:  ToggleRelativeNumber {{{

if !exists('s:relativenumber')
    let s:relativenumber = &relativenumber
endif

function! ToggleRelativeNumber() abort
    for l:w in getwininfo()
        call win_execute(l:w.winid, 'let &g:relativenumber = ' .. !s:relativenumber)
    endfor
    let &l:relativenumber = &g:relativenumber && &l:number
    let s:relativenumber = !s:relativenumber
endfunction

" }}}
" }}}
" SECTION:  COMMAND {{{

command! W silent execute 'write !sudo tee %:S > /dev/null' | edit!

" }}}
" SECTION:  MAPPING {{{
" SECTION:  COMMAND {{{

cnoremap <C-A>   <Home>

" }}}
" SECTION:  INSERT {{{

inoremap <C-L>   <Cmd>nohlsearch<Bar>diffupdate<Bar>redraw<CR>

" }}}
" SECTION:  NORMAL {{{

nnoremap Y       y$
nnoremap _       <Cmd>set termguicolors!<Bar>call ToggleRelativeNumber()<CR>

nnoremap '       `
nnoremap `       '

nnoremap K       <Cmd>call buildMate#Run()<CR>
nnoremap Q       ZQ

nnoremap <F2>    <Cmd>split $MYVIMRC<CR>
nnoremap <F7>    <Cmd>call buildMate#Run()<CR>
nnoremap <F12>   <Cmd>setlocal spell!<CR>

nmap     <C-H>   <Plug>VinegarUp
nnoremap <C-J>   <C-W>j
nnoremap <C-K>   <C-W>k
nnoremap <C-L>   <Cmd>nohlsearch<Bar>diffupdate<CR><C-L>
nnoremap <C-N>   <Cmd>bnext<CR>
nnoremap <C-P>   <Cmd>bprevious<CR>

nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
nnoremap <Left>  <Nop>
nnoremap <Right> <Nop>

" }}}
" SECTION:  TERMINAL {{{

tnoremap <C-J>   <C-W>j
tnoremap <C-K>   <C-W>k

" }}}
" SECTION:  VISUAL {{{

xnoremap *       y/\V<C-R>=substitute(escape(@", '\/'), '\n', '\\n', 'g')<CR><CR>
xnoremap #       y?\V<C-R>=substitute(escape(@", '\?'), '\n', '\\n', 'g')<CR><CR>

xnoremap '       `
xnoremap `       '

xnoremap K       <Nop>
xnoremap Q       <Nop>

xnoremap H       <Nop>
xnoremap M       <Esc><Cmd>'<,'>sort l<CR>
xnoremap L       <Nop>

xnoremap <C-H>   <Nop>
xnoremap <C-J>   <Nop>
xnoremap <C-K>   <Nop>
xnoremap <C-L>   <Nop>
xnoremap <C-N>   <Nop>
xnoremap <C-P>   <Nop>

xnoremap <Up>    <Nop>
xnoremap <Down>  <Nop>
xnoremap <Left>  <Nop>
xnoremap <Right> <Nop>

" }}}
" }}}
" SECTION:  AUTOCMD {{{

augroup MyAutocmdGroup
    autocmd!
    autocmd BufReadPost  *   GitGutter
    autocmd BufWinEnter  *   call s:EntryHook()
    autocmd BufWritePost *   GitGutter
    autocmd BufWritePre  *   call buildMate#Format()
    autocmd CursorHold   *   echo
    autocmd CursorHoldI  *   stopinsert
    autocmd FileType     vim setlocal foldmethod=marker
    autocmd GUIEnter     *   set columns=9999 lines=999
    autocmd InsertEnter  *   setlocal nolist | echo
    autocmd InsertLeave  *   setlocal list
    autocmd VimLeave     *   call delete($HOME .. '/.viminfo')
    autocmd VimResized   *   call s:EntryHook()
    autocmd WinEnter     *   call s:EntryHook()
augroup END

" }}}

" ENDNOTE:  Who You Are Is Not Enough {{{

"                                  Sonnet XIV
"                             William Shakespeare

" Not from the stars do I my judgement pluck;
" And yet methinks I have astronomy,
" But not to tell of good or evil luck,
" Of plagues, of dearths, or seasons’ quality;
" Nor can I fortune to brief minutes tell,
" Pointing to each his thunder, rain and wind,
" Or say with princes if it shall go well,
" By oft predict that I in heaven find:
" But from thine eyes my knowledge I derive,
" And, constant stars, in them I read such art
" As truth and beauty shall together thrive,
" If from thyself to store thou wouldst convert;
"    Or else of thee this I prognosticate:
"    Thy end is truth’s and beauty’s doom and date.

" }}}

"------------------------------ hi, I'm vac--------------------------------
"------------Tempt not a desperate man. -- William Shakespeare-------------
"----------------------------------------------------------------Arch Linux
