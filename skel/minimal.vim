scriptencoding utf-8

set nobackup
set noundofile

autocmd VimLeave * call delete($HOME .. "/.viminfo")
