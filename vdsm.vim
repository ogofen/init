hi api guifg=Blue ctermfg=Green term=bold
hi ERR guifg=Blue ctermfg=Red   term=bold
hi OK  guifg=Blue ctermfg=White term=bold
hi class guifg=BLUE ctermfg=cyan term=bold
hi files guifg=BLUE ctermfg=magenta term=bold

set nocompatible
nmap <S-g> :e<cr>:$<cr>:source /root/log.vim<cr>
nmap q :qa<cr>
