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

scriptencoding utf-8

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
set timeoutlen=0
set ttimeoutlen=50
set updatetime=15000
set winminheight=0
set winminwidth=0

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
set fillchars=vert:│,fold:·,foldsep:│,eob:~
set foldmethod=syntax
set foldopen-=hor
set formatoptions=croqlmBj
set guioptions=c
set listchars=tab:⇥\ ,trail:␣,extends:›,precedes:‹,nbsp:⍽
set mouse=a
set nrformats=bin,hex
set shortmess+=mrWcF
set showbreak=↪\ 
set spelllang=en_us,en_gb
set spellsuggest+=4
set statusline=%F\ \ %q%w%r%m%=%6l,\ %-4c\ %P
set switchbuf=uselast
set viminfo+=n~/.viminfo
set virtualedit=all
set wildmode^=longest:full
silent! set wildoptions=pum,tagfile

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
        let &guifont = "Fira Code " .. s:FONT_SIZE
    elseif s:WINDOWS
        let &guifont = "Fira Code:h" .. s:FONT_SIZE
    endif
endif

" }}}
" SECTION:  PLUGIN {{{

runtime ftplugin/man.vim

let g:PHP_default_indenting = 1
let g:html_indent_script1   = "inc"
let g:html_indent_style1    = "inc"
let g:netrw_dirhistmax      = 0

" }}}
" SECTION:  FUNCTION {{{
" SECTION:  EntryHook {{{

function! s:EntryHook()
    if winwidth(0) > &l:textwidth
        let &l:colorcolumn = &l:textwidth
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
" SECTION:  COMMAND {{{

cnoremap <C-A>   <Home>

" }}}
" SECTION:  INSERT {{{

inoremap <C-L>   <Cmd>redraw<CR>

" }}}
" SECTION:  NORMAL {{{

nnoremap Y       y$

nnoremap '       `
nnoremap `       '

nnoremap *       *N
nnoremap #       #N

nnoremap K       <Cmd>call buildMate#Run()<CR>
nnoremap Q       ZQ

nnoremap <F2>    <Cmd>split $MYVIMRC<CR>
nnoremap <F7>    <Cmd>call buildMate#Run()<CR>
nnoremap <F12>   <Cmd>setlocal spell!<CR>

nnoremap <C-H>   <Cmd>NERDTreeToggle<CR>
nnoremap <C-J>   <C-W>j
nnoremap <C-K>   <C-W>k
nnoremap <C-L>   <Cmd>nohlsearch<Bar>diffupdate<Bar>syntax sync fromstart<CR><C-L>
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

vnoremap '       `
vnoremap `       '

vnoremap *       y/\V<C-R>=escape(getreg('"'), '\/')<CR><CR>N
vnoremap #       y?\V<C-R>=escape(getreg('"'), '\?')<CR><CR>N

vnoremap K       <Nop>
vnoremap Q       <Nop>

vnoremap H       <Nop>
vnoremap M       <Cmd>sort l<CR>
vnoremap L       <Nop>

vnoremap <C-H>   <Nop>
vnoremap <C-J>   <Nop>
vnoremap <C-K>   <Nop>
vnoremap <C-L>   <Nop>
vnoremap <C-N>   <Nop>
vnoremap <C-P>   <Nop>

vnoremap <Up>    <Nop>
vnoremap <Down>  <Nop>
vnoremap <Left>  <Nop>
vnoremap <Right> <Nop>

" }}}
" }}}
" SECTION:  AUTOCMD {{{

augroup MyAutocmdGroup
    autocmd!
    autocmd BufWinEnter *   call s:EntryHook()
    autocmd BufWritePre *   call buildMate#Format()
    autocmd CursorHold  *   echo
    autocmd CursorHoldI *   stopinsert
    autocmd FileType    *   setlocal shiftwidth< softtabstop< tabstop<
    autocmd FileType    vim setlocal foldmethod=marker
    autocmd GUIEnter    *   set columns=1024 lines=1024
    autocmd InsertEnter *   setlocal nolist | echo
    autocmd InsertLeave *   setlocal list
    autocmd VimLeave    *   call delete($HOME .. "/.viminfo")
    autocmd VimResized  *   call s:EntryHook()
    autocmd WinEnter    *   call s:EntryHook()
    autocmd WinLeave    *   call s:EntryHook()
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
