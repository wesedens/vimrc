"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Wes Edens
"
" Version:
"       6.0 - 2016/05/08
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"           https://github.com/wesedens/vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Section: Load pathogen paths {{{1
" ---------------------
set runtimepath+=~/.vim_runtime

silent! execute pathogen#infect("~/.vim_runtime/sources_forked/{}")
silent! execute pathogen#infect("~/.vim_runtime/sources_non_forked/{}")
call pathogen#helptags()

" Section: Options {{{1
" ---------------------

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

set nocompatible
set autoindent                 " Copy indent from current line when starting a new line
set autoread                   " set to auto read when a file is changed from the outside
set backspace=2                " Configure backspace so it acts as it should act

if exists('+breakindent')
  set breakindent showbreak=\ +
endif

set cmdheight=2                " height of the command bar
set dictionary+=/usr/share/dict/words
set display=lastline           " as much as possible of the last line in a window will be displayed
set encoding=utf8              " Set utf8 as standard encoding and en_US as the standard language
set expandtab                  " Use spaces instead of tabs
set fileformats=unix,dos,mac   " Use Unix as the standard file type
set foldcolumn=1               " Add a bit extra margin to the left
set foldmethod=marker          " Markers are used to specify folds.
set foldopen+=jump             " type of commands folds will be opened

if v:version + has("patch541") >= 704
  set formatoptions+=j         " Where it makes sense, remove a comment leader when joining lines
endif

set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
set hid                        " A buffer becomes hidden when it is abandoned
set history=500                " Sets how many lines of history VIM has to remember
set hlsearch                   " Highlight search results
set ignorecase                 " Ignore case when searching
set incsearch                  " Makes search act like search in modern browsers
set laststatus=2               " Always show the status line
set lazyredraw                 " Don't redraw while executing macros (good performance config)
set linebreak                  " Linebreak on 500 characters
set nolist                     " whitespace characters are _not_ made visible

if exists('+macmeta')
  set macmeta
endif

set magic                      " For regular expressions turn magic on
set mat=2                      " How many tenths of a second to blink when matching brackets
set nobackup                   " Turn backup off, since most stuff is in SVN, git et.c anyway...
set noerrorbells               " no bells for error messages
set noswapfile                 " Do not create a swapfile for a new buffer
set novisualbell               " Use visual bell instead of beeping.
set nowritebackup              " Do not make a backup before overwriting a file
set pastetoggle=<F2>
set ruler                      " Always show current position
set scrolloff=5                " Set 7 lines to the cursor - when moving vertically using j/k
set shiftround                 " Round indent to multiple of 'shiftwidth'
set shiftwidth=4               " Number of spaces to use for each step of (auto)indent.
set showcmd                    " Show (partial) command in status line.
set showmatch                  " Show matching brackets when text indicator is over them
set smartcase                  " When searching try to be smart about cases
set smartindent                " smart autoindenting when starting a new line.
set smarttab                   " sw at the start of the line, sts everywhere else
set showtabline=1              " only if there are at least two tab pages
set switchbuf=useopen,usetab   " use open window/tab when switching buffers
set t_vb=
set tabstop=4                  " 1 tab == 4 spaces
set timeoutlen=1200            " A little bit more time for macros
set ttimeoutlen=50             " Make Esc work faster
set tm=500
set tw=500

setglobal tags=./tags;

if exists('+undofile')
  set undodir=~/.vim_runtime/temp_dirs/undodir
  set undofile " Turn persistent undo on
endif

if v:version >= 700
  "set viminfo^=%
  set viminfo=!,'20,<50,s10,h
endif

"set virtualedit=block

set whichwrap+=<,>,h,l
set wildmenu                   " Turn on the WiLd menu
set wildmode=longest:full,full
set wildignore+=tags,*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif

set wrap                       " word wrap lines

if !empty($SUDO_USER) && $USER !=# $SUDO_USER
  set viminfo=
  set directory-=~/tmp
  set backupdir-=~/tmp
endif

" Plugin Settings {{{2
let g:is_bash = 1

" => bufExplorer plugin
let g:bufExplorerDefaultHelp=0
let g:bufExplorerDisableDefaultKeyMapping=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='name'
nnoremap <silent> <leader>o :BufExplorer<cr>

" => CTRL-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20

" => vim-surround, surround.vim config
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1

" => Nerd Tree
let g:NERDTreeHijackNetrw = 0
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

" => vim-multiple-cursors
"let g:multi_cursor_next_key="\<C-s>"

" => vim-airline config (force color)
let g:airline_theme="luna"
let g:airline#extensions#tabline#enabled = 1

" => Syntastic (syntax checker)
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_c_checkers=['make','gcc']
let g:syntastic_enable_signs=1
" }}}2


" }}}1
" Section: Commands {{{1
" -----------------------

if has("eval")
function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
endfunction

command! -bar -nargs=1 -complete=file E :exe "edit ".substitute(<q-args>,'\(.*\):\(\d\+\):\=$','+\2 \1','')
command! -bar -nargs=? -bang Scratch :silent enew<bang>|set buftype=nofile bufhidden=hide noswapfile buflisted filetype=<args> modifiable
function! s:scratch_maps() abort
  nnoremap <silent> <buffer> == :Scratch<CR>
  nnoremap <silent> <buffer> =" :Scratch<Bar>put<Bar>1delete _<Bar>filetype detect<CR>
  nnoremap <silent> <buffer> =* :Scratch<Bar>put *<Bar>1delete _<Bar>filetype detect<CR>
  nnoremap          <buffer> =f :Scratch<Bar>setfiletype<Space>
endfunction

command! -bar Invert :let &background = (&background=="light"?"dark":"light")

function! g:ToggleColorColumn()
    if exists('+colorcolumn')
        if &colorcolumn != ''
            setlocal colorcolumn&
        else
            setlocal colorcolumn=80
        endif
        highlight ColorColumn ctermbg=23 guibg=lightblue
    endif
endfunction

" Old Functions {{{2
" Delete trailing white space on save, useful for Python
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("Ag \"" . l:pattern . "\" " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
" }}}2

endif


" Section: Mappings {{{1
" ----------------------

" Y should perform like C/D
nnoremap Y  y$

" {{{2
"inoremap <C-C> <Esc>`^
"
"vnoremap     <M-<> <gv
"vnoremap     <M->> >gv
"vnoremap     <Space> I<Space><Esc>gv
"
"inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>
"
"cnoremap <C-O>      <Up>
"inoremap <M-o>      <C-O>o
"inoremap <M-O>      <C-O>O
"inoremap <M-i>      <Left>
"inoremap <M-I>      <C-O>^
"inoremap <M-A>      <C-O>$
"noremap! <C-J>      <Down>
"noremap! <C-K><C-K> <Up>
"if has("eval")
"  command! -buffer -bar -range -nargs=? Slide :exe 'norm m`'|exe '<line1>,<line2>move'.((<q-args> < 0 ? <line1>-1 : <line2>)+(<q-args>=='' ? 1 : <q-args>))|exe 'norm ``'
"endif
"
"map  <F1>   <Esc>
"map! <F1>   <Esc>
"nmap <silent> <F6> :if &previewwindow<Bar>pclose<Bar>elseif exists(':Gstatus')<Bar>exe 'Gstatus'<Bar>else<Bar>ls<Bar>endif<CR>
"nmap <silent> <F7> :if exists(':Lcd')<Bar>exe 'Lcd'<Bar>elseif exists(':Cd')<Bar>exe 'Cd'<Bar>else<Bar>lcd %:h<Bar>endif<CR>
"map <F8>    :Make<CR>
"map <F9>    :Dispatch<CR>
"map <F10>   :Start<CR>
"
"noremap  <S-Insert> <MiddleMouse>
"noremap! <S-Insert> <MiddleMouse>
"
"imap <C-L>          <Plug>CapsLockToggle
"Imap <C-G>c         <Plug>CapsLockToggle
"Map <Leader>v  :so ~/.vimrc<CR>
"
"Inoremap <silent> <C-G><C-T> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>
" }}}2

" Old Mappings {{{2
" --------------------

" Fast saving
nnoremap <Leader>w :w<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Copy and paste to system clipboard
vmap <Leader>y  "0y
vmap <Leader>d  "0d
nmap <Leader>p  "0p
nmap <Leader>P  "0P
vmap <Leader>p  "0p
vmap <Leader>P  "0P
vmap <Leader>yy "+y
vmap <Leader>dd "+d
nmap <Leader>pp "+p
nmap <Leader>PP "+P
vmap <Leader>pp "+p
vmap <Leader>PP "+P

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Treat long lines as break lines (useful when moving around in them)
" Make sure that if we want to do something like 'dj' it will do what it should
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

"" Return to last edit position when opening files (You want this!)
"autocmd BufReadPost *
"     \ if line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal! g`\"" |
"     \ endif
"" Remember info about open buffers on close
"set viminfo^=%

" Remap VIM 0 to first non-blank character
map 0 ^

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ag and put the cursor in the right position
map <leader>g :Ag

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pm :setlocal paste!<cr>

" => General abbreviations
iab xdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>

" highlight the 80th color column
nnoremap <silent> <leader>hh :call g:ToggleColorColumn()<CR>

" }}}2
" Section: Autocommands {{{1
" --------------------------
"
if has("autocmd")
  filetype plugin indent on " Enable filetype plugins

  augroup Misc " {{{2
    autocmd!

    """"""""""""""""""""""""""""""
    " => git commit message
    """"""""""""""""""""""""""""""
    autocmd FileType gitcommit set tw=72 | setlocal spell
    autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
    autocmd FileType gitcommit if getline(1)[0] ==# '#' | call s:scratch_maps() | endif
    autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
    autocmd FileType gitrebase nnoremap <buffer> S :Cycle<CR>

    autocmd FileType netrw call s:scratch_maps()
    autocmd FocusLost   * silent! wall
    autocmd FocusGained * if !has('win32') | silent! call fugitive#reload_status() | endif

    autocmd User Fugitive
          \ if filereadable(fugitive#buffer().repo().dir('fugitive.vim')) |
          \   source `=fugitive#buffer().repo().dir('fugitive.vim')` |
          \ endif

    autocmd BufNewFile */init.d/*
          \ if filereadable("/etc/init.d/skeleton") |
          \   keepalt read /etc/init.d/skeleton |
          \   1delete_ |
          \ endif |
          \ set ft=sh

    autocmd BufReadPost * if getline(1) =~# '^#!' | let b:dispatch = getline(1)[2:-1] . ' %' | let b:start = b:dispatch | endif
    autocmd BufReadPost ~/.Xdefaults,~/.Xresources let b:dispatch = 'xrdb -load %'
    autocmd BufWritePre,FileWritePre /etc/* if &ft == "dns" |
          \ exe "normal msHmt" |
          \ exe "gl/^\\s*\\d\\+\\s*;\\s*Serial$/normal ^\<C-A>" |
          \ exe "normal g`tztg`s" |
          \ endif
    autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
      \ if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
  augroup END " }}}2
  augroup FTCheck " {{{2
    autocmd!
    autocmd BufNewFile,BufRead *named.conf*       set ft=named
    autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO if &ft == ""|set ft=text|endif
  augroup END " }}}2
  augroup FTOptions " {{{2
    autocmd!
    let python_highlight_all = 1
    autocmd FileType c,cpp,cs,java          setlocal commentstring=//\ %s
    autocmd Syntax   javascript             setlocal isk+=$
    autocmd FileType xml,xsd,xslt,javascript setlocal ts=2
    autocmd FileType text,txt,mail          setlocal ai com=fb:*,fb:-,n:>
    autocmd FileType sh,zsh,csh,tcsh        inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>
    autocmd FileType sh,zsh,csh,tcsh        let &l:path = substitute($PATH, ':', ',', 'g')
    autocmd FileType perl,python,ruby       inoremap <silent> <buffer> <C-X>! #!/usr/bin/env<Space><C-R>=&ft<CR>
    autocmd FileType c,cpp,cs,java,perl,javscript,php,aspperl,tex,css let b:surround_101 = "\r\n}"
    autocmd FileType apache       setlocal commentstring=#\ %s
    autocmd FileType help setlocal ai fo+=2n | silent! setlocal nospell
    autocmd FileType help nnoremap <silent><buffer> q :q<CR>
    autocmd FileType java let b:dispatch = 'javac %'
    autocmd FileType lua  setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.lua'
    autocmd FileType perl let b:dispatch = 'perl -Wc %'
    autocmd FileType liquid,markdown,text,txt setlocal tw=78 linebreak nolist
    autocmd FileType tex let b:dispatch = 'latex -interaction=nonstopmode %' | setlocal formatoptions+=l
          \ | let b:surround_{char2nr('x')} = "\\texttt{\r}"
          \ | let b:surround_{char2nr('l')} = "\\\1identifier\1{\r}"
          \ | let b:surround_{char2nr('e')} = "\\begin{\1environment\1}\n\r\n\\end{\1\1}"
          \ | let b:surround_{char2nr('v')} = "\\verb|\r|"
          \ | let b:surround_{char2nr('V')} = "\\begin{verbatim}\n\r\n\\end{verbatim}"
    autocmd FileType vim  setlocal keywordprg=:help |
          \ if exists(':Runtime') |
          \   let b:dispatch = ':Runtime' |
          \   let b:start = ':Runtime|PP' |
          \ else |
          \   let b:dispatch = ":unlet! g:loaded_{expand('%:t:r')}|source %" |
          \ endif
  augroup END "}}}2
endif " has("autocmd")

" }}}1
" Section: Visual {{{1
" --------------------

" => Colors and Fonts
syntax enable
if exists("syntax_on") || exists("syntax_manual")
else
  syntax on
endif

set t_Co=256
set background=dark
silent! colorscheme peaksea

" }}}1
