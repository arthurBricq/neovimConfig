""" Personal options
let mapleader = ","

set ignorecase " ignore case when searching
set hlsearch "highlight when searching a word
set tabstop=4
set shiftwidth=4
set autoindent
set number
" set cc=100 " line width for good coding practise
syntax on 
set showmatch
set nowrap
set mouse=a

""" Personal keybindings

" map ctrl+d to open a terminal to the right
noremap <C-d> :vertical :botright :terminal<CR>

" remove search highlight when pressing escape, until next search is triggered
nnoremap <esc><esc> :noh<return>

" Toogle the Tree Explorer
nnoremap <C-t> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Toggle the TagBar (outline)
nnoremap <C-z> :TagbarToggle<CR>

" Shorcuts for my fuzzy finder 
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" For the LSP 
" (Go to .c file, if any)
nnoremap <leader>d :LspDefinition<CR>
" (Go to .h file, if any)
nnoremap <leader>D :LspDeclaration<CR> 

" for folding code 
" za = fold current indentation
" zR = unfold everything
" zM = folds everything
set foldmethod=indent
set foldlevelstart=20

""" Plugin manager

call plug#begin('~/.local/share/nvim/plugged')

Plug 'prabirshrestha/vim-lsp' " I use this plugging for LSP.
Plug 'mattn/vim-lsp-settings' " Since LSP are hard to install, I use this pluggin to do it !
Plug 'Shougo/deoplete.nvim' " autocompletion 1 
Plug 'lighttiger2505/deoplete-vim-lsp' " autocompletion 2
Plug 'preservim/nerdtree' " File Explorer for VIM
Plug 'preservim/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" setting with vim-lsp
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(
      \   lsp#utils#find_nearest_parent_file_directory(
      \     lsp#utils#get_buffer_path(), ['.ccls', 'compile_commands.json', '.git/']))},
      \ 'initialization_options': {
      \   'highlight': { 'lsRanges' : v:true },
      \   'cache': {'directory': stdpath('cache') . '/ccls' },
      \ },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

call plug#end()

""" Autocomplete

let g:deoplete#enable_at_startup = 1

""" LSP Config 

let g:lsp_diagnostics_enabled = 0         " disable diagnostics support

