"Kali Rolling--------------------------------------------------------------
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

syntax on
filetype plugin indent on

" }}}
" SECTION:  SYMBOL {{{

let s:GVIM     = v:false
let s:LINUX    = v:false
let s:TERMINAL = v:false
let s:WINDOWS  = v:false

if has("gui_running") || (exists("+termguicolors") && &termguicolors)
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
set showbreak=↪\ 
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

    if &t_Co >= 256
        highlight ColorColumn  NONE ctermbg=42
        highlight CursorLine   NONE
        highlight CursorLineNr NONE            ctermfg=11  cterm=bold
        highlight LineNr       NONE            ctermfg=240
    else
        highlight ColorColumn  NONE ctermbg=2
        highlight CursorLine   NONE
        highlight CursorLineNr NONE            ctermfg=14  cterm=bold
        highlight LineNr       NONE            ctermfg=8
    endif
else
    set background=dark
    colorscheme nord

    let s:FONT_SIZE = has_key(environ(), "FONT_SIZE") ? $FONT_SIZE : 18

    if s:LINUX
        let &guifont = "Operator Mono Book " . s:FONT_SIZE
    elseif s:WINDOWS
        let &guifont = "Operator Mono Book:h" . s:FONT_SIZE
    endif
endif

" }}}
" SECTION:  PLUGIN {{{

let g:PHP_default_indenting = 1
let g:html_indent_script1   = "inc"
let g:html_indent_style1    = "inc"
let g:netrw_dirhistmax      = 0

" }}}
" SECTION:  FUNCTION {{{
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
nnoremap <silent> <C-J>   <C-W>j
nnoremap <silent> <C-K>   <C-W>k
nnoremap <silent> <C-L>   :nohlsearch<CR><C-L>
nnoremap <silent> <C-N>   :bnext<CR>
nnoremap <silent> <C-P>   :bprevious<CR>

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
    autocmd GUIEnter    *   set columns=1024 lines=1024
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
"-----------------------------------------------------------------GNU/Linux
