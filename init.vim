""" Personal options
let mapleader = ","

set ignorecase " ignore case when searching
set hlsearch "highlight when searching a word
set tabstop=4
set shiftwidth=4
set autoindent
set number
syntax on 
set showmatch
set mouse=a

" Wrap only for markdown files
set nowrap
augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap
augroup END

""" Personal keybindings

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction

" jump to the previous function
nnoremap <silent> [f :call search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
" jump to the next function
nnoremap <silent> ]f :call search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>


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
Plug 'preservim/tagbar' " Function outline
Plug 'jiangmiao/auto-pairs' " To close parenthesis, ...
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdcommenter' 
Plug 'bfredl/nvim-ipy' " Python Kernel in Vim
Plug 'dhruvasagar/vim-table-mode' " For Makdown Tables
Plug 'tpope/vim-fugitive' " Vim Plugin 


"""Setting up the iPython plugin

" Function to run a qtconsole
command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")

let g:ipy_celldef = '^##' " regex for cell start and end

" Useful keybindings
nmap <silent> <leader>jqt :RunQtConsole<Enter>
nmap <silent> <leader>jk :IPython<Space>--existing<Space>--no-window<Enter>
nmap <silent> <leader>jc <Plug>(IPy-RunCell)
nmap <silent> <leader>ja <Plug>(IPy-RunAll)
nmap <silent> <leader>jw <Plug>(IPy-Terminate)

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

