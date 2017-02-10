" Vim 8.x config file optimized for Mac OSX
" Setup leader key to use Space as leader instead of ','

nnoremap <space> <nop>
let mapleader="\<space>"
let maplocalleader="\\"

let g:netrw_silent=1
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap [b :bp<cr>
nnoremap ]b :bn<cr>

nmap <C-p> :Files<cr>

" Open/Close folds with space+tab
nnoremap <leader><tab> za

" Map '-a' to show syntax attribute under cursor (from SyntaxAttr.vim)
nnoremap -a :call SyntaxAttr()<CR>

" EasyAlign mappings
xmap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

set hidden
set relativenumber number
set ignorecase
set smartcase
set noshowmode                 " Do not show extraneous vim info while having powerline show the modes
set backspace=indent,eol,start " allow backspacing backwards past the start
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set updatetime=250             " Recommended setting from vim-gitgutter
set previewheight=25           " Fugitive Gstatus window is a bit small by default

" Note 'tab' won't be visible unless set noexpandtab
" You need to set list for listchars to be visible.
set list listchars=eol:↲,tab:▶\ ,nbsp:␣,extends:…,trail:•

set foldmethod=marker
set foldcolumn=1 " I don't use nested folding much, so 1 column should be plenty
set laststatus=2 " Show statusline even when there is only 1 window active

" Remove all GUI menu's and toolbars
" set guioptions-=T
" set guioptions-=m
" set guioptions-=r
set shortmess+=I "Don't display a startup message when starting a blank Vim.

" Allow Vim to display 24 bit truecolor
set termguicolors
" Since tmux needs TERM to be set to screen-* the below t_ values need to be set manually
" as Vim will not recognize anything not xterm-*
let &t_8f = "[38;2;%lu;%lu;%lum"
let &t_8b = "[48;2;%lu;%lu;%lum"

" Default FZF setting
"set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND='find . -type f -o -type l|cut -b3-'

" Always show the gitgutter column to avoid screen moving when it appears
let g:gitgutter_sign_column_always = 1
" Directory management (backup, undo, swap) {{{1
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
    :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif

set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup//
set backupdir^=./.vim-backup//
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
    :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
    " undofile - This allows you to use undos after exiting and restarting
    " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
    " :help undo-persistence
    " This is only present in 7.3+
    if isdirectory($HOME . '/.vim/undo') == 0
        :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=./.vim-undo//
    set undodir+=~/.vim/undo//
    set undofile
endif


" Plugins {{{1
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                 " Seems to have problems this way. Simply works with .fzf added to rtp
Plug 'junegunn/vim-easy-align'
" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-scriptease'             " Allow K to lookup vim language features in help. Lots of other things too, but this is the main thing I use it for.
Plug 'tpope/vim-abolish'
" Plug 'chriskempson/base16-vim'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'                " Allow alignment based on a pattern/character
" Plug 'guns/xterm-color-table.vim'       " Enables XtermColorTable command. Press # to yank, t to toggle RGB, f to set fg
Plug 'mileszs/ack.vim'
" Plug 'PProvost/vim-ps1'                 " PowerShell syntax coloring
Plug 'sjbach/lusty'
Plug 'terryma/vim-multiple-cursors'     " Allows Sublime style multiple cursors!
Plug 'tomtom/tcomment_vim'
Plug 'edkolev/tmuxline.vim'             " Will sync tmux look and feel to match vim-airline themes selected.
Plug 'vim-airline/vim-airline'          " Prefer this over Powerline as it seems more configurable
Plug 'vim-airline/vim-airline-themes'   " Themes are now a separate plugin
Plug 'airblade/vim-gitgutter'           " Show Git changes in the gutter line.
Plug 'vim-scripts/SyntaxAttr.vim'       " Call SyntaxAttr() to find attibute under cursor.
Plug 'msanders/snipmate.vim'            " enter text+tab to expand dynamic text with preset tabstops etc.
" Plug 'altercation/vim-colors-solarized' " Vim specific Solarized theme.
call plug#end()

" EasyMotion setup {{{1

" Look at :help easymotion for more motions/mappings.
let g:EasyMotion_do_mapping = 0     " Disable default mappings
let g:EasyMotion_smartcase  = 1

" Make EasyMotion prefix just <leader> and not <leader><leader>
map <Leader> <Plug>(easymotion-prefix)

map <Leader>f <Plug>(easymotion-f)
map <Leader>F <Plug>(easymotion-F)
map <Leader>t <Plug>(easymotion-t)
map <Leader>T <Plug>(easymotion-T)
map <Leader>w <Plug>(easymotion-w)
map <Leader>W <Plug>(easymotion-W)
map <Leader>b <Plug>(easymotion-b)
map <Leader>B <Plug>(easymotion-B)
map <Leader>e <Plug>(easymotion-e)
map <Leader>E <Plug>(easymotion-E)
map <Leader>gE <Plug>(easymotion-gE)
map <Leader>ge <Plug>(easymotion-ge)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>n <Plug>(easymotion-n)
map <Leader>N <Plug>(easymotion-N)
map <Leader>s <Plug>(easymotion-s)
" Make 's' search anywhere for two characters (even other windows)
nmap s <Plug>(easymotion-overwin-f2)
" Overide Vims built-in '/' search. Use 'tab' and 'shift-tab' to move around.
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" Use remapped 'n' and 'N' when moving around.
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
" Airline settings {{{1

let g:airline_powerline_fonts = 1
" let g:airline_theme="bubblegum"
let g:airline#extensions#tabline#enabled = 0

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : '#I #W#F',
      \'cwin' : '#I #W#F',
      \'y'    : '#(uptime |sed "s/^.* up /Up /;s/  / /g;s/load average:/load:/")',
      \'z'    : '%a %d-%b-%Y %H:%M:%S',
      \'options' : {'status-justify' : 'left'}}

"Finalizing setup {{{1

colorscheme jelleybeans
syntax on

