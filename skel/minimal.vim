scriptencoding utf-8

set nobackup
set noundofile

autocmd VimLeave * silent call delete($HOME . "/.viminfo")
