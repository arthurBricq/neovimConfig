" Welcome
if exists('g:vscode')
	finish 
endif 



""" Plugin manager

call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocompletioon: back-end
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'preservim/nerdtree' " File Explorer for VIM
Plug 'jistr/vim-nerdtree-tabs' " Second pluging to have the same tree on all tabs
Plug 'ryanoasis/vim-devicons' " Icons for NeerTree
Plug 'preservim/tagbar' " Function outline
Plug 'jiangmiao/auto-pairs' " To close parenthesis, ...
" This two pluggin are for the uzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter' " Commenter
Plug 'bfredl/nvim-ipy' " Python Kernel in Vim
Plug 'dhruvasagar/vim-table-mode' " For Makdown Tables
Plug 'github/copilot.vim' " Vim Github Copilot Plugin 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/argtextobj.vim' " Plugin to add 'argument' as text object
call plug#end()


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

" Set undodir (to have 'u' command forever)
set undodir=~/.config/nvim/.vimdid
set undofile

" Search and Replace selected text
vnoremap <C-r> "hy:%s/\<<C-r>h\>//g<left><left>

" jump to the previous function
nnoremap <silent> [f :call search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "bw")<CR>
	
" jump to the next function
nnoremap <silent> ]f :call search('\(\(if\\|for\\|while\\|switch\\|catch\)\_s*\)\@64<!(\_[^)]*)\_[^;{}()]*\zs{', "w")<CR>

" remove search highlight when pressing escape, until next search is triggered
nnoremap <esc><esc> :noh<return>

" Toggle the TagBar (outline)
nnoremap <C-z> :TagbarToggle<CR>

" Shorcuts for my fuzzy finder 
nnoremap <leader>ff <cmd>:Files<cr>
nnoremap <leader>fg <cmd>:Rg<cr>

" Git push shortcut
nnoremap <C-s> :!/usr/bin/gp.sh "Updates from vim."<CR>

" For the LSP 
" (Go to .c file, if any)
nnoremap <leader>d :LspDefinition<CR>
" (Go to .h file, if any)
nnoremap <leader>D :LspDeclaration<CR> 

" LSP Config 
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support

" for folding code 
" za = fold current indentation
" zR = unfold everything
" zM = folds everything
set foldmethod=indent
set foldlevelstart=20

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Pick the theme to use 
let g:airline_theme='light'

" Change the fuzzy finder command 
"command! -bang -nargs=* Rg
  "\ call fzf#vim#grep(
  "\   'rg --column --line-number --no-heading --color=always --smart-case -u -- '.shellescape(<q-args>), 1,
  "\   fzf#vim#with_preview(), <bang>0)
" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

command! -bang -nargs=* Rgc
     \ call fzf#vim#grep("rg --column --line-number --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right', 'ctrl-/'), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case -u -- ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('up', 'ctrl-/'), 1)

" Function to run a qtconsole
command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")
let g:ipy_celldef = '^##' " regex for cell start and end
nmap <silent> <leader>jqt :RunQtConsole<Enter>
nmap <silent> <leader>jk :IPython<Space>--existing<Space>--no-window<Enter>
nmap <silent> <leader>jc <Plug>(IPy-RunCell)
nmap <silent> <leader>ja <Plug>(IPy-RunAll)
nmap <silent> <leader>jw <Plug>(IPy-Terminate)

" For the Tree Explorer
noremap <C-b> :NERDTreeTabsToggle<CR>
let NERDTreeMapOpenInTab='<C-t>'
