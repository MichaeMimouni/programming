execute pathogen#infect()

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp^=~/.vim/bundle/ctrlp.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-ctrlspace/vim-ctrlspace'

call vundle#end()

filetype on
filetype plugin on
filetype indent on

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()
"VAMActivate PLUGIN_NAME PLUGIN_NAME ..
"VAMActivate vim-snippets snipmate

scriptencoding utf-8
set nocompatible
"ctrlspace
set hidden
set showtabline=2
let g:airline#extensions#tabline#enabled = 1

set ai
set backspace=2
syn on

"solarized
set background=dark
colorscheme solarized

set ts=2
set sw=2
set nu

set encoding=utf8
set expandtab
set softtabstop=2

set laststatus=2

if has("statusline")
  set statusline=%<%F\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif

"last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

nmap ; :tabnext<CR>
nmap , :tabprevious<CR>
nmap <s-Right> :wincmd l<CR>
nmap <s-Left> :wincmd h<CR>
nmap <c-t> :NERDTree<CR>

function! Gtab()
  hi TabLineSel term=underline,reverse cterm=underline,reverse ctermfg=37 ctermbg=7 gui=bold
  redraw
  sleep 300m
  hi TabLineSel term=underline,reverse cterm=underline,reverse ctermfg=10 ctermbg=7 gui=bold
endfunction

nmap t :call Gtab()<CR>

"force this or it's buggy
let JSHintUpdateWriteOnly=1

set nofoldenable

let mapleader="ù"

"indent guide
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

let g:neocomplete#enable_at_startup = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:airline_powerline_fonts = 1
