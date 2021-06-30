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

"Markdown interpreation and integration.
" Requires Pandoc 2.x
Plug 'https://github.com/vim-pandoc/vim-pandoc'
Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax'

"Plug '~/my-prototype-plugin'
"Statusline customization
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/powerline/fonts.git'

"Language interpretation
Plug 'https://github.com/vim-syntastic/syntastic.git'

"coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"ALE for error symbol in the left side symbol gutter
"Plug 'w0rp/ale'

" Initialize plugin system
call plug#end()

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '' "<insert> Ctrl+V U nnnn esc
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = ''		"'㏑'
let g:airline_symbols.branch =''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace ='' 		"'Ξ'

"==== Manual vim settings
set tabstop=2
set shiftwidth=2
set expandtab

set number
set mouse=a
set noswapfile

set virtualedit=all

"======== Remap Arrow Keys

"======== Pandoc
autocmd FileType pandoc :lchdir %:p:h
function Render_In_HTML()
  if &filetype ==? 'pandoc'
    execute ':Pandoc! html'
  else
    echo &filetype "not supported"
  endif
endfunction

command -nargs=0 Preview call Render_In_HTML()

"======== Gutter/SignColumn
highlight SignColumn ctermbg=NONE
"highlight CocHintFloat ctermfg=Red guifg=#ff0000
highlight Pmenu ctermfg=Red ctermbg=Black 

"====================================================================================
"<leader> is not currently defined so defaults to '\'. i.e. use '\lm' to bring 
" up the context menu

