set nobackup
set noundofile

autocmd VimLeave * silent call delete($HOME . "/.viminfo")
