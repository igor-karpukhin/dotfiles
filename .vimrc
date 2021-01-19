set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'dkprice/vim-easygrep'
Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'cormacrelf/vim-colors-github'
Plugin 'w0rp/ale'
Plugin 'mdempsky/gocode', {'rtp': 'vim/'}
Plugin 'ervandew/supertab'
Plugin 'junegunn/fzf', { 'dir': '/usr/local/Cellar/fzf/0.17.1/bin', 'do': './install --all' }
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mxw/vim-jsx'
Plugin 'posva/vim-vue'
Plugin 'mattn/emmet-vim'
Plugin 'jremmen/vim-ripgrep'
Plugin 'mbbill/undotree'
Plugin 'brookhong/cscope.vim'
Plugin 'stephpy/vim-yaml'
Plugin 'tpope/vim-rhubarb'
" RipGrep executable
if executable('rg')
	let g:rg_derive_root='true'
endif

" UndoTree
:nnoremap <leader>u :UndotreeShow<CR>
"Undo persistence
set undodir=~/.vim/undodir
"VIM BACKUP DIR (*.swp, *.swp)
"set backupdir=~/.vim/swapfiles//
"
"Navigation between buffers
:nnoremap <C-Down> :bprevious<CR>
:nnoremap <C-Up> :bnext<CR>
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

" Enable backspace
:set backspace=indent,eol,start
" Share clipboard
set clipboard=unnamed,unnamedplus

" Nerdtree
"autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
map <C-g> :NERDTreeToggle<CR>

" Colorscheme and font
colorscheme gruvbox
set guioptions=
set guifont=Fira\ Code:h14

"Set line numbers
set nu

" Set delay for updating status in the statusline
set ttimeoutlen=50

" Set terminal colors
set termguicolors
set t_Co=256

" Supertab complemetion to filetype
let g:SuperTabDefaultCompletionType = 'context'

" Show errors on the status line
let g:airline#extensions#ale#enabled = 1

" Generic autocomplete on Ctrl+Space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" Vim FZF plugin
let g:fzf_prefer_vim_terminal = 1
:nnoremap <C-p> :FZF<CR>
function! s:find_project_root()
  let nerd_root = g:NERDTree.ForCurrentTab().getRoot().path.str()
  let git_root = system('git -C '.shellescape(nerd_root).' rev-parse --show-toplevel 2> /dev/null')[:-2]
  if strlen(git_root)
    return git_root
  endif
  return nerd_root
endfunction
command! ProjectFiles execute 'Files' s:find_project_root()

" Go autocomplete
auto FileType go setlocal omnifunc=go#complete#Complete
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode = 'guru'
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1
let g:go_play_open_browser = 0
let g:go_textobj_enabled = 1
let g:go_auto_type_info = 1
let g:ale_open_list = 0
let g:go_gocode_propose_source=0
au FileType go nmap <Leader>d <Plug>(go-def)
autocmd FileType python,go setlocal completeopt-=preview
autocmd FileType python,go setlocal completeopt=longest,menuone

" ALE Linter & Fixed settings
let g:ale_open_list = 0
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {'go':['gofmt', 'go build', 'go lint'], 'c':['clang'], 'java':['javac'], 'jsx': ['stylelint', 'eslint'], 'rust':['rls']}
let g:ale_fixers = {
\    'go': ['gofmt', 'goimports'],
\    'c': ['clang-format'],
\    'cpp': ['clang-format'],
\    'js': ['eslint'],
\    'python': ['yapf'],
\    'rust': ['rustfmt'],
\}
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 200
let g:ale_completion_enabled = 0
highlight clear ALEWarningSign
nmap <silent> <leader>an :ALENext<cr>
nmap <silent> <leader>ap :ALEPrevious<cr>
" Vim speed improvements
set noshowmatch
set nocursorline
set nocursorcolumn
"set lazyredraw
set nolazyredraw
set scrolljump=8
set history=700
let html_no_rendering=1

" TOGGLE SEARCH HIGHLIGHT
nnoremap <F3> :set hlsearch!<CR>

"EMMET CONFIGURATION
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

"REMOVE TRAILING CHARACTERS ON SAVE
autocmd FileType yaml,yml,html,css,c,proto,javascript,make,python autocmd BufWritePre <buffer> %s/\s\+$//e
"FILE TYPES
autocmd FileType make set noexpandtab sw=8 sts=0
autocmd FileType python set tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType javascript set tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType typescript set tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType cpp set sw=2 ts=2 sts=2 expandtab tabstop=2
autocmd FileType c set sw=2 ts=2 sts=2 expandtab tabstop=2
autocmd FileType proto set tabstop=4 noexpandtab shiftwidth=4 softtabstop=4
autocmd FileType yaml setlocal ts=2 sw=2 sts=2 expandtab cuc
set background=dark

"CSCOPE
let g:cscope_silent=1
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
