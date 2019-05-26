" Vim config file optimized for Mac OSX
" Author: Magnus Oberg

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
nmap <leader>L :Lines<cr>

" Open/Close folds with space+tab
nnoremap <leader><tab> za

" Map '-a' to show syntax attribute under cursor (from SyntaxAttr.vim)
nnoremap -a :call SyntaxAttr()<CR>

" EasyAlign mappings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Case-insensitive searching. Uppercase searches still match only upper-case.
set ignorecase
set smartcase

set hidden
set relativenumber number
set modeline                   " Allow modelines to set settings
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
set scrolloff=5                " Scroll offset for top/bottom of window

set clipboard=unnamed           " Allow yanking to system clipboard
set mouse=a

" Note 'tab' won't be visible unless set noexpandtab
" You need to set list for listchars to be visible.
" set list listchars=eol:↲,tab:▶\ ,nbsp:␣,extends:…,trail:•
set list listchars=tab:▶\ ,nbsp:␣,extends:…,trail:•

set foldmethod=marker " Use marks for folding... not syntax
set foldcolumn=1      " I don't use nested folding much, so 1 column should be plenty
set laststatus=2      " Show statusline even when there is only 1 window active
set shortmess+=I      " Don't display a startup message when starting a blank Vim.

" allow hanging indent for lists, and allow -,+, and * as bulleted list items
" useful for GitCommit messages
set formatoptions+=n
set autoindent
set formatlistpat=^\\s*\\d\\+[\]:.)}\\t\ ]\\s*\\\|^\\s*[-+*]\\s\\+

" Only set Truecolor if Vim supports it
if has("termguicolors")
    " Allow Vim to display 24 bit truecolor
    set termguicolors

    " Since tmux needs TERM to be set to screen-* or tmux* the below t_ values need to be set manually
    " as Vim will not recognize anything not xterm-*
    let &t_8f = "[38;2;%lu;%lu;%lum"
    let &t_8b = "[48;2;%lu;%lu;%lum"

    " Disable Background Color Erase (BCE) so colorschemes work properly.
    " https://sunaku.github.io/vim-256color-bce.html
    " set t_ut=

endif

if $TERM_PROGRAM =~ "iTerm"
    " Change cursor shape
    " let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    " let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    " let &t_SR = "\<Esc>]50;CursorShape=2\x7" " Underline in replace mode

    " Below is specifically for running tmux in iTerm2
    " https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
    " let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"  " Block in normal mode
    " let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"  " Vertical bar in insert mode
    " let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"  " Underline in replace mode

endif

" Default FZF setting: if you had used Homebrew to install fzf
set rtp+=/usr/local/opt/fzf

" Use fd instead of find and grep
let $FZF_DEFAULT_COMMAND='fd -tf --hidden --follow'

" vim-gitgutter tweaks:
" Realtime updates stopped working, fixed by following:
"   https://github.com/airblade/vim-gitgutter/issues/490#issuecomment-369270014
let g:gitgutter_terminal_reports_focus = 0
set signcolumn=yes

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


" Airline settings {{{1

let g:airline_powerline_fonts = 1
" let g:airline_theme="bubblegum"

let g:airline#extensions#tabline#enabled = 0
" let g:airline_left_sep=''
" let g:airline_right_sep=''

" let g:tmuxline_separators = {
"       \ 'left' : '',
"       \ 'left_alt': '',
"       \ 'right' : '',
"       \ 'right_alt' : '',
"       \ 'space' : ' '}

" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'win'  : '#I #W#F',
"       \'cwin' : '#I #W#F',
"       \'y'    : '#(uptime |sed "s/^.* up /Up /;s/  / /g;s/load average:/load:/")',
"       \'z'    : '%a %d-%b-%Y %H:%M:%S',
"       \'options' : {'status-justify' : 'left'}}

" Plugins {{{1

" Install 'junegunn/vim-plug' if not already installed & install plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" fzf is not really a vim plugin, but fzf.vim will need it installed in order to run properly
" Could simply use: Plug '~/.fzf' to reference the binary, but the below will install fzf if missing.
" It will also allow vim to auto-update OS version using :PlugUpdate
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'

" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'               " run asynchronous shell tasks through :Dispatch
Plug 'tpope/vim-rhubarb'                " vim 'hub' to allow :Gbrowse to browse GitHub code

Plug 'vim-scripts/visualrepeat'         " recommended by vim-easy-align to repeat alignments on visual selections
Plug 'michaeljsmith/vim-indent-object'  " Allows indentation ai, ii, aI (and iI) level text objects
" Plug 'nathanaelkane/vim-indent-guides'  " Allows indentation guides (shadows)

" Allow 'K' to lookup vim language features in help
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-abolish'

" Plug 'chriskempson/base16-vim'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'                " Allow alignment based on a pattern/character
" Plug 'guns/xterm-color-table.vim'     " Enables XtermColorTable command. Press # to yank, t to toggle RGB, f to set fg
Plug 'mileszs/ack.vim'                  " Supports ag as well as ack
" Plug 'jremmen/vim-ripgrep'              " Use :Rg for searches
" Plug 'PProvost/vim-ps1'               " PowerShell syntax coloring

" Lusty requires Ruby to work
" Use 'Plug' syntax for conditionally loading only if support is there.
" Avoids a problem with PlugClean removing bundle if not supported.
" See https://github.com/junegunn/vim-plug/wiki/faq for more details
Plug 'sjbach/lusty', has('ruby') ? {} : { 'on': [] }
Plug 'terryma/vim-multiple-cursors'     " Allows Sublime style multiple cursors!
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'          " Prefer this over Powerline as it seems more configurable
Plug 'vim-airline/vim-airline-themes'   " Themes are now a separate plugin

" Disabled because I became annoyed at tmuxline changing the color of the
" divider lines of tmux panes. They became too dark and almost not visible.
" Plug 'edkolev/tmuxline.vim'           " Will sync tmux look and feel to match vim-airline themes selected.
Plug 'airblade/vim-gitgutter'           " Show Git changes in the gutter line.
Plug 'vim-scripts/SyntaxAttr.vim'       " Call SyntaxAttr() to find attibute under cursor.

" Required by vim-snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'              " enter text+tab to expand dynamic text with preset tabstops etc.

" Vim note-taking plugin
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

Plug 'vim-syntastic/syntastic'

" Allows syntax highlighting in .tmux.conf and also 'K' navigation to tmux man page
Plug 'tmux-plugins/vim-tmux'

" Add Kotlin syntax support
Plug 'udalov/kotlin-vim'

" Vim specific Solarized theme
" Plug 'altercation/vim-colors-solarized'

call plug#end()

" EasyMotion setup {{{1

" Look at :help easymotion for more motions/mappings.
let g:EasyMotion_do_mapping = 0     " Disable default mappings
let g:EasyMotion_smartcase  = 1

" Make EasyMotion prefix just <leader> and not <leader><leader>
map <Leader><Leader> <Plug>(easymotion-prefix)

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
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" " Overide Vims built-in '/' search. Use 'tab' and 'shift-tab' to move around.
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" " Use remapped 'n' and 'N' when moving around.
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)
" mappings for colormap: <leader> c {{{1
" <leader>c to choose color schemes interactively
nnoremap <silent> <Leader>c :call fzf#run({
            \   'source':
            \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
            \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
            \   'sink':    'colo',
            \   'options': '+m',
            \   'left':    30
            \ })<CR>

"colorscheme and hightlights{{{1
" No need to set 'syntax on', or 'filetype plugin indent' etc. as 'Plug' takes
" care of all that. So all that remains is to select the colorscheme :)

" The MyHighlights() function and MyColors augroup need to be defined BEFORE
" calling any colorscheme
function! MyHighlights() abort
    hi NonText                guibg=NONE
    hi Normal                 guibg=NONE
    hi LineNr                 guibg=NONE
    hi StatusLine             guibg=NONE
    hi Comment                guibg=NONE cterm=italic guifg=#808080
    hi vimComment             guibg=NONE cterm=italic guifg=#808080
    hi vimLineComment         guibg=NONE cterm=italic guifg=#808080
    hi Folded                 guibg=NONE
    hi FoldColumn             guibg=NONE
    hi GitGutterAdd           guibg=NONE guifg=#00ff00
    hi GitGutterDelete        guibg=NONE guifg=#ff0000
    hi GitGutterChange        guibg=NONE guifg=#ffff00
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

colorscheme jellybeans
