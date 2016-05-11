# The Ultimate vimrc

Over the last 8 years I have used and tweaked Vim. This is my Ultimate vimrc.

## How to install?
This includes a lot of great plugins, configurations and color schemes that make Vim a lot better. To install it simply do following:

	git clone git://github.com/wesedens/vimrc.git ~/.vim_runtime
	sh ~/.vim_runtime/install_vimrc.sh

Navigating with ctags is recommended. (Debian: apt-get install exuberant-ctags)

## How to install on Windows?

Use [msysgit](http://msysgit.github.com/) to checkout the repository and run the installation instructions above. No special instructions needed ;-)


## How to update to latest version?

Simply just do a git rebase!

    cd ~/.vim_runtime
    git pull --rebase


## Some screenshots

Colors when editing a Python file:
![Screenshot 1](http://files1.wedoist.com/e952fdb343b1e617b90d256e474d0370/as/screenshot_1.png)

[NERD Tree](https://github.com/scrooloose/nerdtree) plugin in a terminal window:
![Screenshot 2](http://files1.wedoist.com/b1509d7ed9e9f357e8d04797f9fad67b/as/screenshot3.png)

This vimrc even works on Windows!
![Screenshot 3](http://files1.wedoist.com/4e85163d97b81422240c822c82022f2f/as/screenshot_4.png)


## Included Plugins

I recommend reading the docs of these plugins to understand them better. Each of them provide a much better Vim experience!

* [pathogen.vim](https://github.com/tpope/vim-pathogen): Manages the runtime path of the plugins

* [ag.vim](https://github.com/rking/ag.vim): Vim plugin for the silver surfer
* [bufexplorer](https://github.com/jlanzarotta/bufexplorer): Buffer Explorer / Browser. This plugin can be opened with `<leader+o>`
* [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim): Fuzzy file, buffer, mru and tag finder. In my config it's mapped to `<Ctrl+F>`, because `<Ctrl+P>` is used by YankRing
* [NERD Tree](https://github.com/scrooloose/nerdtree): A tree explorer plugin for vim
* [open_file_under_cursor.vim](https://github.com/amix/open_file_under_cursor.vim): Open file under cursor when pressing `gf`
* [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object): Defines a new text object representing lines of code at the same indent level. Useful for python/vim scripts
* [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors): Sublime Text style multiple selections for Vim, CTRL+N is remapped to CTRL+S (due to YankRing)
* [vim-expand-region](https://github.com/terryma/vim-expand-region): Allows you to visually select increasingly larger regions of text using the same key combination.
* [vim-airline](https://github.com/vim-airline/vim-airline): Lean & mean status/tabline for vim that's light as air (replacing powerline)
* [vim-fugitive](https://github.com/tpope/vim-fugitive): A Git wrapper so awesome, it should be illegal
Remove all clutter and focus only on the essential. Similar to iA Writer or Write Room [Read more here](http://amix.dk/blog/post/19744)
* [vim-commentary](https://github.com/tpope/vim-commentary): Comment stuff out.  Use `gcc` to comment out a line (takes a count), `gc` to comment out the target of a motion. `gcu` uncomments a set of adjacent commented lines.
* [syntastic](https://github.com/scrooloose/syntastic): Syntax checking hacks for vim


## Included color schemes

* [peaksea](https://github.com/vim-scripts/peaksea): My favorite!


## Included modes

* [vim-markdown](https://github.com/tpope/vim-markdown)
* [nginx.vim](https://github.com/vim-scripts/nginx.vim): Highlights configuration files for nginx


## Key Mappings

### Plugin related mappings

Open bufexplorer and see and manage the current buffers:
    
    map <leader>o :BufExplorer<cr>

Open [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) plugin:
    
    let g:ctrlp_map = '<c-p>'

Managing the [NERD Tree](https://github.com/scrooloose/nerdtree) plugin:

    map <leader>nn :NERDTreeToggle<cr>
    map <leader>nb :NERDTreeFromBookmark 
    map <leader>nf :NERDTreeFind<cr>

### Normal mode mappings

Fast saving of a buffer:

	nmap <leader>w :w!<cr>

Treat long lines as break lines (useful when moving around in them). But they
should still function correctly with commands like 'dj' 'dk':

    nnoremap <expr> j v:count ? 'j' : 'gj'
    nnoremap <expr> k v:count ? 'k' : 'gk'
	
Disable highlight when `<leader><cr>` is pressed:
	
	map <silent> <leader><cr> :noh<cr>

Smart way to move between windows:
	
	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l

Useful mappings for managing tabs:
	
	map <leader>tn :tabnew<cr>
	map <leader>to :tabonly<cr>
	map <leader>tc :tabclose<cr>
	map <leader>tm :tabmove 
	
	" Opens a new tab with the current buffer's path
	" Super useful when editing files in the same directory
	map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
	
Open vimgrep and put the cursor in the right position:
	
	map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

Vimgreps in the current file:
	
	map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

Remove the Windows ^M - when the encodings gets messed up:
	
	noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
	

Toggle paste mode on and off:
	
	map <leader>pm :setlocal paste!<cr>


### Insert mode mappings

Insert the current date and time (useful for timestamps):

    iab xdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>


### Visual mode mappings

Visual mode pressing `*` or `#` searches for the current selection:

	vnoremap <silent> * :call VisualSelection('f')<CR>
	vnoremap <silent> # :call VisualSelection('b')<CR>

When you press gv you vimgrep after the selected text:

	vnoremap <silent> gv :call VisualSelection('gv')<CR>

When you press `<leader>r` you can search and replace the selected text:

	vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>


### Command line mappings

Write the file as sudo (only on Unix). Super useful when you open a file and you don't have permissions to save your changes. [Vim tip](http://vim.wikia.com/wiki/Su-write):

    :W 


### Spell checking
Pressing `<leader>ss` will toggle and untoggle spell checking

    map <leader>ss :setlocal spell!<cr>

Shortcuts using `<leader>` instead of special chars

    map <leader>sn ]s
    map <leader>sp [s
    map <leader>sa zg
    map <leader>s? z=

### Cope	
Do :help cope if you are unsure what cope is. It's super useful!

When you search with vimgrep, display your results in cope by doing:
`<leader>cc`

To go to the next search result do:
`<leader>n`

Vimscript mappings:

    map <leader>cc :botright cope<cr>
    map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
    map <leader>n :cn<cr>
    map <leader>p :cp<cr>
