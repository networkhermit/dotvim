"Kali Rolling--------------------------------------------------------------
"-------------------------------Vi IMproved--------------------------------
"--------------------This is my Vim configuration file.--------------------

" PREFACE:  First Breath After Coma {{{

"                         Comforting Sounds -- Mew

" I don't feel alright in spite of these comforting sounds you make.
" I don't feel alright because you make promises that you break.
" Into your house, why don't we share our solitude?
" Nothing is pure anymore but solitude.

" It's hard to make sense, feels as if I'm sensing you through a lens.
" If someone else comes, I'd just sit here listening to the drums.
" Previously I never called it solitude.
" And probably you know all the dirty shows I've put on.
" Blunted and exhausted like anyone.
" Honestly I tried to avoid it. Honestly.

" Back when we were kids, we would always know when to stop.
" And now all the good kids are messing up.
" Nobody has gained or accomplished anything.

" }}}

" SECTION:  PRELUDE {{{

syntax on
filetype plugin indent on

" }}}
" SECTION:  SYMBOL {{{

let s:GVIM     = v:false
let s:LINUX    = v:false
let s:TERMINAL = v:false
let s:WINDOWS  = v:false

if has("gui_running")
    let s:GVIM     = v:true
else
    let s:TERMINAL = v:true
endif

if has("unix") || has("mac")
    let s:LINUX    = v:true
elseif has("win64") || has("win32")
    let s:WINDOWS  = v:true
endif

" }}}
" SECTION:  OPTION {{{
" SECTION:  TURN ON {{{

set autochdir
set autoindent
set breakindent
set expandtab
set hidden
set hlsearch
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
set ttyfast
set wildmenu

" }}}
" SECTION:  TURN OFF {{{

set nobackup
set nofileignorecase
set noincsearch
set nojoinspaces
set nomodeline
set nospell
set noundofile
set nowrap

" }}}
" SECTION:  NUMBER {{{

set cmdwinheight=1
set foldnestmax=2
set helpheight=0
set linespace=0
set matchtime=1
set previewheight=1
set pumheight=15
set report=0
set scrolloff=4
set shiftwidth=4
set sidescroll=1
set softtabstop=4
set tabstop=8
set textwidth=80
set timeoutlen=0
set updatetime=15000
set winheight=1
set winminheight=0
set winminwidth=0
set winwidth=1

" }}}
" SECTION:  STRING {{{

set backspace=indent,eol,start
set breakindentopt+=sbr
set browsedir=buffer
set cinoptions+=g0
set completeopt+=longest
set diffopt+=vertical,foldcolumn:0
set display=lastline
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,prc,taiwan,latin1
set fileformats=unix,dos,mac
set foldmethod=syntax
set foldopen-=hor
set formatoptions=croqlmB1j
set guioptions=c
set listchars=tab:»\ ,trail:·,extends:›,precedes:‹
set mouse=a
set rulerformat=%16(%6l,\ %-4c\ %P%)
set shortmess+=mrWc
set showbreak=›\
set spelllang=en_us,en_gb
set spellsuggest+=4
set statusline=%F\ \ %q%w%r%m%=%6l,\ %-4c\ %P
set viminfo+=n~/.viminfo
set virtualedit=all
set wildmode^=longest:full

" }}}
" }}}
" SECTION:  SCHEME {{{

if s:TERMINAL
    set background=light
    colorscheme default

    highlight ColorColumn  NONE ctermbg=42
    highlight CursorLine   NONE
    highlight CursorLineNr NONE            ctermfg=11  cterm=bold
    highlight LineNr       NONE            ctermfg=240
else
    set background=dark
    colorscheme macvim

    if s:LINUX
        set guifont=Operator\ Mono\ Book\ 16
    elseif s:WINDOWS
        set guifont=Operator_Mono_Book:h16
    endif
endif

" }}}
" SECTION:  PLUGIN {{{

let g:PHP_default_indenting           = 1
let g:PHP_vintage_case_default_indent = 1
let g:html_indent_script1             = "inc"
let g:html_indent_style1              = "inc"
let g:netrw_dirhistmax                = 0

" }}}
" SECTION:  FUNCTION {{{
" SECTION:  BlockData {{{

function! BlockData()
    let l:lines       = wordcount()["chars"] ? line('$') : 0
    let l:words       = wordcount()["words"]

    let l:encoding    = empty(&fileencoding) ? &encoding : &fileencoding
    let l:line_ending = &fileformat
    let l:buffer_id   = bufnr('%')
    let l:file_type   = empty(&filetype)     ? "Nil"     : &filetype

    let l:read_only   = &readonly            ? "[RO]"    : ""
    let l:modifiable  = &modifiable          ? ""        : "[-]"
    let l:modified    = &modified            ? "[+]"     : ""

    return printf("\t%06d, %06d  %s ¦ %s  #%s  %s%s%s", l:lines, l:words,
                \ l:encoding, l:line_ending, l:file_type,
                \ l:read_only, l:modifiable, l:modified)
endfunction

" }}}
" SECTION:  EntryHook {{{

function! s:EntryHook()
    if winwidth(0) > 80
        let &l:colorcolumn = 80
        let &l:cursorline  = 1
        let &l:number      = 1
    else
        let &l:colorcolumn = 0
        let &l:cursorline  = 0
        let &l:number      = 0
    endif
endfunction

" }}}
" SECTION:  LocalTime {{{

function! LocalTime()
    let l:uptime = localtime() - s:STARTUP_TIME

    let l:hour   = l:uptime / 3600
    let l:minute = l:uptime % 3600 / 60
    let l:second = l:uptime % 60

    return printf("\t%s, ↑ %02d:%02d", strftime("%A %Y-%m-%d %H:%M"),
                \ l:hour, l:minute)
endfunction

" }}}
" }}}
" SECTION:  MAPPING {{{
" SECTION:  NORMAL {{{

nnoremap <silent> '       `
nnoremap <silent> `       '

nnoremap <silent> *       *N
nnoremap <silent> #       #N

nnoremap <silent> &       :wall<CR>
nnoremap <silent> _       :setlocal spell!<CR>

nnoremap <silent> H       8zh
nnoremap <silent> M       mmzngg=G`mzz
nnoremap <silent> L       8zl

nnoremap <silent> K       :call buildMate#start()<CR>
nnoremap <silent> Q       :bwipeout<CR>

nnoremap <silent> -       :setlocal cursorline! number!<CR>
nnoremap <silent> <CR>    o<Esc>0d$
nnoremap <silent> <Space> i<Space><Esc>l

nnoremap <silent> <F2>    :split $MYVIMRC<CR>
nnoremap <silent> <F7>    :call buildMate#start()<CR>

nnoremap <silent> <C-^>   O<Esc>0d$
nnoremap <silent> <C-H>   :echo LocalTime()<CR>
nnoremap <silent> <C-J>   <C-W>j
nnoremap <silent> <C-K>   <C-W>k
nnoremap <silent> <C-L>   :nohlsearch<CR><C-L>
nnoremap <silent> <C-N>   :bnext<CR>
nnoremap <silent> <C-P>   :bprevious<CR>
nnoremap <silent> <C-G>   :echo BlockData()<CR>

nnoremap <silent> <Up>    <C-U>
nnoremap <silent> <Down>  <C-D>
nnoremap <silent> <Left>  zH
nnoremap <silent> <Right> zL

" }}}
" SECTION:  VISUAL {{{

vnoremap <silent> '       `
vnoremap <silent> `       '

vnoremap <silent> *       y/\V<C-R>=escape(getreg('"'), '\/')<CR><CR>N
vnoremap <silent> #       y?\V<C-R>=escape(getreg('"'), '\?')<CR><CR>N

vnoremap <silent> H       <Nop>
vnoremap <silent> M       :sort<CR>
vnoremap <silent> L       <Nop>

vnoremap <silent> K       <Nop>
vnoremap <silent> Q       <Nop>

vnoremap <silent> -       <Nop>
vnoremap <silent> <CR>    <Nop>
vnoremap <silent> <Space> <Nop>

vnoremap <silent> <C-^>   <Nop>
vnoremap <silent> <C-H>   <Nop>
vnoremap <silent> <C-J>   <Nop>
vnoremap <silent> <C-K>   <Nop>
vnoremap <silent> <C-L>   <Nop>
vnoremap <silent> <C-N>   <Nop>
vnoremap <silent> <C-P>   <Nop>
vnoremap <silent> <C-G>   <Nop>

vnoremap <silent> <Up>    8k
vnoremap <silent> <Down>  8j
vnoremap <silent> <Left>  8h
vnoremap <silent> <Right> 8l

" }}}
" SECTION:  INSERT {{{

inoremap <silent> <C-E>   <C-X><C-E>
inoremap <silent> <C-Y>   <C-X><C-Y>

" }}}
" }}}
" SECTION:  AUTOCMD {{{

augroup MyAutocmdGroup
    autocmd!
    autocmd BufWinEnter *   silent call s:EntryHook()
    autocmd CursorHold  *   echo
    autocmd CursorHoldI *   stopinsert
    autocmd FileType    *   setlocal shiftwidth< softtabstop< tabstop<
    autocmd FileType    vim setlocal foldmethod=marker
    autocmd GUIEnter    *   set columns=80 lines=24
    autocmd InsertEnter *   setlocal nolist | echo
    autocmd InsertLeave *   setlocal list
    autocmd VimEnter    *   let s:STARTUP_TIME = localtime()
    autocmd VimLeave    *   silent call delete($HOME . "/.viminfo")
    autocmd VimResized  *   silent call s:EntryHook()
    autocmd WinEnter    *   silent call s:EntryHook()
    autocmd WinLeave    *   silent call s:EntryHook()
    autocmd WinLeave    *   setlocal colorcolumn=0
augroup END

" }}}

" ENDNOTE:  Who You Are Is Not Enough {{{

"                            Ⅲ -- Athletics

" I read your note, and I know just what you want to hear.
" It hurts less over time, but I'm not getting stronger.
" I just leave pieces behind.
" And I can only fall so many times before I'm broke, unrecognizable.
" Now all I've left to give is the piece that still remains,
"                                        and you bring the pieces back.
" Love, it only reconstructs the pain.
" As time fails to elapse, I'm finding you were everything to me.
" Now my future and my past are ending tragically the same.

" }}}

"------------------------------ hi, I'm vac--------------------------------
"------------Tempt not a desperate man. -- William Shakespeare-------------
"-----------------------------------------------------------------GNU/Linux
