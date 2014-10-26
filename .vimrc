" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
execute pathogen#infect()
"let g:ycm_filetype_specific_completion_to_disable={ 'cpp' :1}
"let g:ycm_show_diagnostics_ui = 0
" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif
imap <S-Right> <C-o>v
imap <S-Left> <Left><C-o>v
set pumheight=5
" ================ General Config ====================
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set laststatus=2
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
set expandtab
nmap a <nop>
nmap a :set paste<cr>i
au InsertLeave * silent execute "set nopaste"
"turn on syntax highlighting
syntax on
"imap <C-shift-z> <c-o>:redo<cr>
" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let g:mapleader = "'"
let g:acp_mappingDriven =0
nmap <S-g> :e<cr>:$<cr>:source /root/log.vim<cr>
function! Foo()
   :qa!
endfunction
colorscheme cool
hi EasyMotionShade guibg=white ctermfg=white
highlight Pmenu ctermfg=white ctermbg=lightblue
highlight PmenuSel ctermfg=white ctermbg=magenta
" Fast saving
nmap <leader>q :q<cr>
nmap <leader>z :execute Foo()<cr>
nmap <leader>x :x!<cr>
imap <C-a> :call QuickfixToggle()<cr>
" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif
" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb
let g:quickfix_is_open = 0
" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
"set undodir=~/.vim/backups
"set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \.,trail:·

set wrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=syntax   "fold based on indent
set foldnestmax=40       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
nmap <F2> :%foldc<cr>
imap <F2> <C-o>:%foldc<cr>
imap <F3> <C-o>:%foldo<cr>
nmap <F3> :%foldo<cr>
" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

imap <C-t> <C-o>:NERDTree<cr>
nmap <C-t> :NERDTree<cr>
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
"====== My shit =======

" use an orange cursor in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"  silent !echo -ne \033]12;white\007
	" reset cursor when vim exits
autocmd VimLeave * silent !echo -ne \033]112\007
autocmd InsertLeave * silent set nopaste

  " use \003	]12;gray\007 for gnome-terminal
set autochdir
imap <C-Left>     <esc>:tabp<CR><ins>
nmap <C-Left>		   :tabp<CR>
imap <C-right>     <esc>:tabn<CR><ins>
nmap <C-right>			:tabn<CR>
"imap <C-Left> <C-o>:wincmd h<cr>
"imap <C-Right> <C-o>:wincmd k<cr>
"nmap <C-Left> :wincmd h<cr>
"nmap <C-Right> :wincmd k<cr>
let g:session_autosave = 'yes'
vmap <C-x> d
nmap <C-e>       :Error<CR>
imap <C-e> <Nop>
imap <C-e>  <C-o>:Error<CR>
imap <C-\>  <C-o>:set paste<cr>
"============ statusline =============
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%8*\ %<%F%*
set statusline+=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

function! GuiTabLabeler()
  let tabno = tabpagenr()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '[+]'
      break
    endif
  endfor

  " Append the number of windows in the tab page if more than one
  let wincount = tabpagewinnr(v:lnum, '$')
  if wincount > 1
    let label .= ' [' . wincount . ']'
  endif
  " Append the buffer name
  return tabno . " " . 
         \ fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ":t")
         \ . label
endfunction

set guitablabel=%!GuiTabLabeler()
nmap q :q<cr>

"========== Insert Mode mappings =======
imap <C-w>  <C-o>e
imap <C-b>  <C-o>b
vmap <S-Down> j
vmap <S-Right> l
vmap <S-Left> h
vmap <Left> v<Left>
vmap <Right> v<Right>
vmap <C-c> y
imap <C-f> <esc>:MRU<CR>
nmap <C-f>		:MRU<CR>
"========save?====
nmap <C-s> :w!<cr>
imap <C-s> <C-o>:w!<cr>
set guioptions-=r
set guioptions-=T

nmap a <nop>
nmap s <nop>
imap <C-v> <C-o>P
set guioptions+=r<Bar><cr>
augroup mine
    au BufWinEnter * sign define mysign
    au BufWinEnter * exe "sign place 1337 line=1 name=mysign buffer=" . bufnr('%')
augroup END
hi SignColumn ctermfg=3 guifg=#93a1a1 guibg=#eee8d5
hi SyntasticErrorLine guifg=red
nmap <C-l> :TlistToggle<cr>
set completeopt=menu,longest
vmap <S-Up> k
hi Visual  guifg=#000000 guibg=white gui=none ctermfg=white
hi MatchParen ctermbg=none ctermfg=red
set statusline+=%F
hi TabLine ctermfg=yellow ctermbg=blue
hi TabLineSel ctermfg=yellow ctermbg=white
nmap > :call EasyMotionWB(0 ,0)<cr>
nmap < :call EasyMotionWB(0 ,1)<cr>

