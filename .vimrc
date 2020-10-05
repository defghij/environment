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

Plug '~/my-prototype-plugin'
"Statusline customization
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/powerline/fonts.git'

"Language interpretation
Plug 'https://github.com/vim-syntastic/syntastic.git'

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
