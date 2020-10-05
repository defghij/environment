" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Any valid git URL is allowed
"
"Some Basic QOL things
Plug 'https://github.com/tpope/vim-sensible.git'

"Git integration
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

"Plug '~/my-prototype-plugin'
"Statusline customization
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/powerline/fonts.git'

"Language interpretation
Plug 'https://github.com/vim-syntastic/syntastic.git'

"Language client for neovim
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh', }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf'

"ALE for error symbol in the left side symbol gutter
Plug 'w0rp/ale'


" Initialize plugin system
call plug#end()

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '' "<insert> Ctrl+V U nnnn esc
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '李'		"'㏑'
let g:airline_symbols.branch ='⎇ '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace ='' 		"'Ξ'

"Manual vim settings
"
"tab -> 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

"Enable line numbers
set number

"Enable mouse
set mouse=a

"No swap files
set noswapfile

"Language client for vim (LanguageClient-neovim)
"====================================================================================
" Required for operations modifying multiple buffers like rename.
set hidden
"
"\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
 let g:LanguageClient_serverCommands = {
     \ 'rust': ['/home/defghij/.local/bin/rust-analyzer'],
     \ 'python': ['/home/defghij/.local/bin/pyls'],
     \ }

let g:LanguageClient_autoStart = 1
"let g:LanguageClient_hoverPreview = "Never" "requires vim v8.

"<leader> is not currently defined so defaults to '\'. i.e. use '\lm' to bring 
" up the context menu
function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,rust call SetLSPShortcuts()
augroup END


let g:LanguageClient_diagnosticsDisplay = {
      \1: {
      \     "name": "Error",
      \     "texthl": "ALEError",
      \     "signText": "",
      \     "signTexthl": "ALEErrorSign",
      \     "virtualTexthl": "Error",
      \ },
      \ 2: {
      \     "name": "Warning",
      \     "texthl": "ALEWarning",
      \     "signText": "⚠",
      \     "signTexthl": "ALEWarningSign",
      \     "virtualTexthl": "Todo",
      \ },
      \ 3: {
      \     "name": "Information",
      \     "texthl": "ALEInfo",
      \     "signText": "ℹ",
      \     "signTexthl": "ALEInfoSign",
      \     "virtualTexthl": "Todo",
      \ },
      \ 4: {
      \     "name": "Hint",
      \     "texthl": "ALEInfo",
      \     "signText": "➤",
      \     "signTexthl": "ALEInfoSign",
      \     "virtualTexthl": "Todo",
      \ },
      \}

"SignColumn Definition for ALE and Vim
"====================================================================================
let g:ale_sign_column_always = 1
highlight ALEErrorSign ctermfg=9 ctermbg=NONE guifg=#C30500 guibg=#F5F5F5
highlight ALEWarningSign ctermfg=11 ctermbg=NONE guifg=#ED6237 guibg=#F5F5F5
highlight SignColumn ctermbg=NONE

