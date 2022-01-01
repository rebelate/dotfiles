call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'terrortylor/nvim-comment'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-compe'
Plug 'tami5/lspsaga.nvim', {'branch':'nvim51'}
nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>

Plug 'folke/trouble.nvim'
Plug 'hrsh7th/vim-vsnip'
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
let g:vsnip_filetypes.javascript = ['javascript']
let g:vsnip_filetypes.svelte = ['javascript']

Plug 'rafamadriz/friendly-snippets'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
" Prettier Settings
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

" Plug 'dense-analysis/ale'
" let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
" let g:ale_linters = {'svelte': ['stylelint', 'eslint']}

Plug 'Shougo/context_filetype.vim'
if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.svelte =
\ [
\   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\ ]

let g:ft = ''

Plug 'windwp/nvim-autopairs'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'matze/vim-move'
" Plug 'folke/which-key.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
Plug 'mhinz/vim-startify'
Plug 'chrisbra/Colorizer'
Plug 'andweeb/presence.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

" General {{{
	" Map Capslock when nvim started and reset on closing 
	" :silent !setxkbmap -option caps:swapescape
	" :silent au VimLeave * !setxkbmap -option
    " Abbreviations
    abbr funciton function
    abbr teh the
    abbr tempalte template
    abbr fitler filter
    abbr cosnt const
    abbr attribtue attribute
    abbr attribuet attribute

    set autoread " detect when a file is changed
	" autocmd BufEnter * silent! lcd %:p:h
    " WARNING: These settings disable vim's backups (swap files).
    " If this is not desired, comment these lines out.
    set nobackup " don't use backup files
    set nowritebackup " don't backup the file while editing
    set noswapfile " Don't create swapfiles for new buffers
    set updatecount=0 " don't try to write swap files after some number of updates

    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp " change where swap files are stored"
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

    set history=1000 " store the last 1000 command-lines entered

    set textwidth=120

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    set backspace=indent,eol,start " make backspace behave in a sane manner
    set clipboard=unnamedplus

    if has('mouse')
        set mouse=a
    endif

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " set incremental search, like modern browsers
    set nolazyredraw " don't redraw while executing macros

    set magic " Set magic on, for regex

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500
" }}}

" Appearance {{{
	set pumheight=10 "set completion popup items
    set number " show line numbers
    set wrap " turn on line wrapping
    set wrapmargin=8 " wrap lines when coming within n characters from side
    set linebreak " set soft wrapping
    set showbreak=↪
    set autoindent " automatically set indent of new line
    set ttyfast " faster redrawing
    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
    set laststatus=2 " show the status line all the time
    set so=7 " set 7 lines to the cursors - when moving vertical
    set wildmenu " enhanced command line completion
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set noshowmode " don't show which mode disabled for PowerLine
    set wildmode=list:longest " complete files like a shell
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink
    set updatetime=300
    set signcolumn=yes
    set shortmess-=S " Show [X/X] search results

    " Tab control
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=4 " the visible width of tabs
    set softtabstop=4 " edit as if the tabs are 4 characters wide
    set shiftwidth=2 " number of spaces to use for indent and unindent
    set shiftround " round indent to a multiple of 'shiftwidth'

    " code folding settings
    set foldmethod=syntax " fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 " deepest fold is 10 levels
    set nofoldenable " don't fold by default
    set foldlevel=1

    " toggle invisible characters
    set list
    " set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    " switch cursor to line when in insert mode, and block when not
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    " enable 24 bit color support if supported
    if (has("termguicolors"))
        if (!(has("nvim")))
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
        set termguicolors
    endif

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " Load colorschemes
    Plug 'rebelate/onedark-red'

    call plug#end()

    colorscheme onedark
	hi Normal guibg=NONE ctermbg=NONE
    let &fcs='eob: ' "hide tilde color
" }}}

" LSP {{{
	" auto-format
	autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
	autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
	autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
		
	inoremap <silent><expr> <C-Space> compe#complete()
	inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
	inoremap <silent><expr> <C-e>     compe#close('<C-e>')
	inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
	inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" }}}

" NvimTree {{{
    let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
	let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
	let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
	let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
	let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
	let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
	let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
	let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
	let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
	let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
	let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
	let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
	let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
	let g:nvim_tree_window_picker_exclude = {
		\   'filetype': [
		\     'notify',
		\     'packer',
		\     'qf'
		\   ],
		\   'buftype': [
		\     'terminal'
		\   ]
		\ }
	" Dictionary of buffer option names mapped to a list of option values that
	" indicates to the window picker that the buffer's window should not be
	" selectable.
	let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
	let g:nvim_tree_show_icons = {
		\ 'git': 1,
		\ 'folders': 1,
		\ 'files': 1,
		\ 'folder_arrows': 0,
		\ }
	"If 0, do not show the icons for one of 'git' 'folder' and 'files'
  "1 by default, notice that if 'files' is 1, it will only display
  "if nvim-web-devicons is installed and on your runtimepath.
  "if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
  "but this will not work when you set indent_markers (because of UI conflict)

  " default will show icon by default if no icon is provided
  " default shows no icon by default
  let g:nvim_tree_icons = {
	  \ 'default': '',
	  \ 'symlink': '',
	  \ 'git': {
	  \   'unstaged': "✗",
	  \   'staged': "✓",
	  \   'unmerged': "",
	  \   'renamed': "➜",
	  \   'untracked': "★",
	  \   'deleted': "",
	  \   'ignored': "◌"
	  \   },
	  \ 'folder': {
	  \   'arrow_open': "",
	  \   'arrow_closed': "",
	  \   'default': "",
	  \   'open': "",
	  \   'empty': "",
	  \   'empty_open': "",
	  \   'symlink': "",
	  \   'symlink_open': "",
	  \   }
	  \ }

  nnoremap <C-n> :NvimTreeToggle<CR>
  nnoremap <leader>r :NvimTreeRefresh<CR>
  nnoremap <leader>n :NvimTreeFindFile<CR>
  " NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

  set termguicolors " this variable must be enabled for colors to be applied properly

  " a list of groups can be found at `:help nvim_tree_highlight`
  highlight NvimTreeFolderIcon guibg=blue
"}}}


" General Mappings {{{
    " set a map leader for more key combos
    let mapleader = ','
    
    " set a timeout
    set timeoutlen=500
	" :autocmd InsertEnter * set timeoutlen=250
	" :autocmd InsertLeave * set timeoutlen=100

	nmap <C-h> <C-w>h
	nmap <C-l> <C-w>l
	nmap <C-j> <C-w>j
	nmap <C-k> <C-w>k

	noremap  <C-t>  :FloatermToggle<CR>
	noremap! <C-t>  <Esc> :FloatermToggle<CR>
	tnoremap <C-t>  <C-\><C-n>:FloatermToggle<CR>

	" buffer list
	nnoremap gb :ls<CR>:buffer<Space>

	" close buffer
	nmap <leader>c :bd<cr>

    " remap esc
    inoremap jk <esc>
	" cnoremap jk <C-c>

    " shortcut to save
    nmap <leader>, :w<cr>

    " set paste toggle
    set pastetoggle=<leader>v

    " edit ~/.config/nvim/init.vim
    map <leader>ev :e! ~/.config/nvim/init.vim<cr>
    " edit gitconfig
    map <leader>eg :e! ~/.gitconfig<cr>

    " clear highlighted search
    noremap <space> :set hlsearch! hlsearch?<cr>

    " activate spell-checking alternatives
    nmap ;s :set invspell spelllang=en<cr>

    " markdown to html
    nmap <leader>md :%!markdown --html4tags <cr>

    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

    inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
    inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

    nmap <leader>l :set list!<cr>

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<cr>

    " map <silent> <C-h> <Plug>WinMoveLeft
    " map <silent> <C-j> <Plug>WinMoveDown
    " map <silent> <C-k> <Plug>WinMoveUp
    " map <silent> <C-l> <Plug>WinMoveRight

    nmap <leader>z <Plug>Zoom

    map <leader>wc :wincmd q<cr>

    " move line mappings
    " ∆ is <A-j> on macOS
    " ˚ is <A-k> on macOS
    nnoremap ∆ :m .+1<cr>==
    nnoremap ˚ :m .-2<cr>==
    inoremap ∆ <Esc>:m .+1<cr>==gi
    inoremap ˚ <Esc>:m .-2<cr>==gi
    vnoremap ∆ :m '>+1<cr>gv=gv
    vnoremap ˚ :m '<-2<cr>gv=gv

    vnoremap $( <esc>`>a)<esc>`<i(<esc>
    vnoremap $[ <esc>`>a]<esc>`<i[<esc>
    vnoremap ${ <esc>`>a}<esc>`<i{<esc>
    vnoremap $" <esc>`>a"<esc>`<i"<esc>
    vnoremap $' <esc>`>a'<esc>`<i'<esc>
    vnoremap $\ <esc>`>o*/<esc>`<O/*<esc>
    vnoremap $< <esc>`>a><esc>`<i<<esc>

    " toggle cursor line
    nnoremap <leader>i :set cursorline!<cr>

    " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " moving up and down work as you would expect
    nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
    nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <silent> <expr> ^ (v:count == 0 ? 'g^' :  '^')
    nnoremap <silent> <expr> $ (v:count == 0 ? 'g$' : '$')

    " helpers for dealing with other people's code
    nmap \t :set ts=4 sts=4 sw=4 noet<cr>
    nmap \s :set ts=4 sts=4 sw=4 et<cr>

    nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>

    command! Rm call functions#Delete()
    command! RM call functions#Delete() <Bar> q!

    " Custom text objects

    " inner-line
    xnoremap <silent> il :<c-u>normal! g_v^<cr>
    onoremap <silent> il :<c-u>normal! g_v^<cr>

    " around line
    vnoremap <silent> al :<c-u>normal! $v0<cr>
    onoremap <silent> al :<c-u>normal! $v0<cr>

    " Interesting word mappings
    nmap <leader>0 <Plug>ClearInterestingWord
    nmap <leader>1 <Plug>HiInterestingWord1
    nmap <leader>2 <Plug>HiInterestingWord2
    nmap <leader>3 <Plug>HiInterestingWord3
    nmap <leader>4 <Plug>HiInterestingWord4
    nmap <leader>5 <Plug>HiInterestingWord5
    nmap <leader>6 <Plug>HiInterestingWord6

    " open current buffer in a new tab
    nmap <silent> gTT :tab sb<cr>
" }}}

" Airline {{{
    let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
	let g:airline_filetype_overrides = {
      \ 'coc-explorer':  [ 'CoC Explorer', '' ],
      \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
      \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
      \ 'gundo': [ 'Gundo', '' ],
      \ 'help':  [ 'Help', '%f' ],
      \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
	  \ 'NvimTree': [ 'Tree', '' ],
      \ }

    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

	" airline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''

" }}}

	:lua require('config')
