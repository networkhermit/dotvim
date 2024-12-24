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
let s:WINDOWS = v:false

if has('linux')
    let s:LINUX = v:true
elseif has('mac')
    let s:MACOS = v:true
elseif has('win64')
    let s:WINDOWS = v:true
endif

let s:TERMINAL = v:true
let s:VANILLA_VIM = v:true

if has('gui_running')
    let s:TERMINAL = v:false
endif

if has('nvim')
    let s:VANILLA_VIM = v:false
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
set textwidth=100
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
set showbreak=↪\ "
set spelllang=en_us,en_gb
set spellsuggest+=6
set switchbuf=uselast
set viminfo+=n~/.viminfo
set virtualedit=all
set wildmode=longest:full,full

" }}}
" }}}
" SECTION:  SCHEME {{{

if s:WINDOWS
    set shell=pwsh.exe
    set shellcmdflag=-Command
    if s:VANILLA_VIM
        set renderoptions=type:directx
    endif
endif

if s:TERMINAL
    if s:VANILLA_VIM
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
        elseif s:WINDOWS
            set t_Co=256
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
        highlight VertSplit    NONE
    endif
else
    set background=dark
    colorscheme nord

    let s:font_size = empty($FONT_SIZE) ? 12 : $FONT_SIZE

    if s:LINUX
        let &guifont = 'Fira Code ' .. s:font_size
    elseif s:MACOS || s:WINDOWS
        let &guifont = 'Fira Code:h' .. s:font_size
    endif
endif

" }}}
" SECTION:  PLUGIN {{{

runtime ftplugin/man.vim

let g:netrw_dirhistmax = 0

" }}}
" SECTION:  FUNCTION {{{
" SECTION:  LayoutChangedHook {{{

if s:VANILLA_VIM
function! s:Callback() abort
    set colorcolumn< cursorline< number< relativenumber<
endfunction
else
function! s:Callback() abort
    if &buftype isnot# 'terminal'
        set colorcolumn< cursorline< number< relativenumber<
    endif
endfunction
endif

function! s:Dim() abort
    setglobal colorcolumn= nocursorline norelativenumber
    let &g:number = winwidth(0) > &g:textwidth
    call s:Callback()
endfunction

function! s:Focus() abort
    if winwidth(0) > &g:textwidth
        setglobal colorcolumn=+1 cursorline number
    else
        setglobal colorcolumn= nocursorline nonumber
    endif
    let &g:relativenumber = s:relativenumber && &g:number
    call s:Callback()
endfunction

function! s:LayoutChangedHook() abort
    wincmd =
    for l:winid in gettabinfo(tabpagenr())[0]['windows']
        call win_execute(l:winid, 'let &g:number = winwidth(0) > &g:textwidth | set number<')
    endfor
    call s:Focus()
endfunction

" }}}
" SECTION:  OpenInTerminal {{{

if s:VANILLA_VIM
function! OpenInTerminal() abort
    terminal
endfunction
else
function! OpenInTerminal() abort
    new
    terminal
    autocmd TermClose <buffer> execute 'bwipeout! ' .. expand('<abuf>')
endfunction
endif

" }}}
" SECTION:  ToggleRelativeNumber {{{

if !exists('s:relativenumber')
    let s:relativenumber = &relativenumber
endif

function! ToggleRelativeNumber() abort
    let &g:relativenumber = !s:relativenumber && &g:number
    call s:Callback()
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
nnoremap _       <Cmd>call ToggleRelativeNumber()<CR>

nnoremap '       `
nnoremap `       '

nnoremap K       <Cmd>call OpenInTerminal()<CR>
nnoremap Q       ZQ

nnoremap <F2>    <Cmd>split $MYVIMRC<CR>
nnoremap <F7>    <Cmd>call buildMate#Run()<CR>
nnoremap <F12>   <Cmd>set termguicolors!<Bar>setlocal spell!<CR>

nmap     <C-H>   <Plug>VinegarUp
nnoremap <C-J>   <C-W>j
nnoremap <C-K>   <C-W>k
nnoremap <C-L>   <Cmd>nohlsearch<Bar>diffupdate<CR><C-L>
nnoremap <C-N>   <Cmd>bnext<CR>
nnoremap <C-P>   <Cmd>bprevious<CR>

" }}}
" SECTION:  TERMINAL {{{

tnoremap <C-J>   <Cmd>wincmd j<CR>
tnoremap <C-K>   <Cmd>wincmd k<CR>

if s:VANILLA_VIM
tnoremap <C-W>   <C-W>.
endif

" }}}
" SECTION:  VISUAL {{{

xnoremap *       y/\V<C-R>=substitute(escape(@", '\/'), '\n', '\\n', 'g')<CR><CR>
xnoremap #       y?\V<C-R>=substitute(escape(@", '\?'), '\n', '\\n', 'g')<CR><CR>

xnoremap '       `
xnoremap `       '

xnoremap K       <Nop>
xnoremap Q       <Nop>

xnoremap H       <Nop>
xnoremap M       <Esc><Cmd>'<,'>sort<CR>
xnoremap L       <Nop>

xnoremap <C-H>   <Nop>
xnoremap <C-J>   <Nop>
xnoremap <C-K>   <Nop>
xnoremap <C-L>   "+y
xnoremap <C-N>   <Nop>
xnoremap <C-P>   <Nop>

if s:VANILLA_VIM && !empty($TMUX) && !empty($SSH_CONNECTION)
function! TmuxCopy() abort
    let l:result = systemlist('base64 --wrap 0', @")
    if v:shell_error
        echohl ErrorMsg
        echomsg printf('command failed with exit code %s:', v:shell_error)
        for l:line in l:result
            echomsg l:line
        endfor
        echohl None
        return
    endif
    let l:selection_data = result[0]
    let l:escape_sequence = printf("\033]52;c;%s\007", l:selection_data)
    let l:client_tty = empty($SSH_TTY) ? systemlist('tmux display-message -p ''#{client_tty}''')[0] : $SSH_TTY
    call writefile([l:escape_sequence], l:client_tty, "ab")
endfunction
xnoremap <C-L>   y<Cmd>call TmuxCopy()<CR>
endif

" }}}
" }}}
" SECTION:  AUTOCMD {{{

augroup MyAutocmdGroup
    autocmd!
    autocmd BufReadPost,BufWritePost * GitGutter
    autocmd BufWinEnter * call s:Callback()
    autocmd BufWritePre * call buildMate#Format()
    autocmd CursorHold * echo
    autocmd CursorHoldI * stopinsert
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FocusGained,VimEnter,WinEnter * call s:Focus()
    autocmd FocusLost,WinLeave * call s:Dim()
    autocmd GUIEnter * set columns=9999 lines=999
    autocmd InsertEnter * setlocal nolist | echo
    autocmd InsertLeave * setlocal list
    autocmd VimLeave * call delete(expand('~/.viminfo'))
    autocmd VimResized * call s:LayoutChangedHook()
augroup END

if s:VANILLA_VIM
    function! s:VimResizedHook() abort
        if !empty($TMUX)
            if systemlist('tmux display-message -p -t "${TMUX_PANE}" ''#{pane_active}''') == ['0']
                doautocmd FocusLost
            else
                doautocmd FocusGained
            endif
        endif
    endfunction

    augroup VimTweak
        autocmd!
        autocmd VimResized * call s:VimResizedHook()
    augroup END
else
    function! s:TerminalEnteredHook() abort
        setlocal nonumber norelativenumber
        startinsert
    endfunction

    function! s:TerminalResizedHook() abort
        if mode() is# 't'
            setlocal nonumber norelativenumber
        else
            set number< relativenumber<
        endif
    endfunction

    function! s:TerminalOpenedHook() abort
        call s:TerminalEnteredHook()
        autocmd BufEnter <buffer> call s:TerminalEnteredHook()
        autocmd TermEnter <buffer> call s:TerminalEnteredHook()
        autocmd TermLeave <buffer> set number< relativenumber<
        autocmd VimResized <buffer> call s:TerminalResizedHook()
    endfunction

    augroup NeovimTweak
        autocmd!
        autocmd TermOpen * call s:TerminalOpenedHook()
    augroup END
endif

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
