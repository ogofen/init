" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
imap <C-Down> <Left><Right><Down>
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
"turn on syntax highlighting
syntax on
"imap <C-shift-z> <c-o>:redo<cr>
" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.

let g:mapleader = "'"
nmap <S-g> :e<cr>:$<cr>:source /root/log.vim<cr>
function! Foo()
   :qa!
endfunction


imap <C-z> <C-o>:qa!<cr>
" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>z :execute Foo()<cr>
nmap <leader>x :x!<cr>

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

set nowrap       "Don't wrap lines
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

"if pumvisible()
 "           imap <Down> <C-o>

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"====== My shit =======

if &term =~ "xterm\\|rxvt"
 " use an orange cursor in insert mode
	let &t_SI = "\<Esc>]12;green\x7"
	:" VimLeave * silent execute !gconftool-2 --type string --set /apps/gnome-terminal/profiles/Profile0/cursor_shape block"
  " use a red cursor otherwise
	let &t_EI = "\<Esc>]12;yellow\x7"
	"  silent !echo -ne \033]12;white\007
	" reset cursor when vim exits
   "autocmd VimLeave * silent !echo -ne \033]112\007
  " use \003	]12;gray\007 for gnome-terminal
endif

function! Log()
	hi Error ctermfg=red
	hi File ctermfg=3
	hi class ctermfg=cyan
	hi Command ctermfg=green
	hi Ok ctermfg=white
	hi Regular ctermfg=yellow

	match Command /getReadDelay _getDiskStats _getDiskLatency reloadlvs/
endfunction

function! Log1()
	silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Profile0/cursor_shape ibeam"
	endfunction


set autochdir

imap <C-Left>     <esc>:tabp<CR>i
nmap <C-Left>		   :tabp<CR>
imap <C-right>     <esc>:tabn<CR>i
nmap <C-right>			:tabn<CR>
nmap <CR> i<CR><esc>
"imap <C-Left> <C-o>:wincmd h<cr>
"imap <C-Right> <C-o>:wincmd k<cr>
"nmap <C-Left> :wincmd h<cr>
"nmap <C-Right> :wincmd k<cr>

let g:session_autosave = 'yes'
vmap <C-x> d
nmap <C-e>       :Error<CR>
imap <C-e> <Nop>
imap <C-e>  <C-o>:Error<CR>
imap <C-]>  <C-o>:
imap <c-\> <A-Down>:close<CR>
nmap <c-\> <A-Down>:close<CR>
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
nmap <C-z> <NOP>
nmap <C-z> u
nmap r :redo<cr>
imap <C-u>  <C-o><Leader><Leader>b
imap <C-d>  <C-o><Leader><Leader>w
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
"========save?===
nmap <c-s> :w<CR>
imap <c-s> <C-o>:w<CR>
set guioptions-=r
set guioptions-=T

imap <A-;> <nop>
imap <A-;> <C-o>:
nmap <A-;> :
vmap <A-;> :
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

