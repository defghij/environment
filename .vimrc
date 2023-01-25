
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
"Plug 'https://github.com/tpope/vim-fugitive.git'
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

"Statusline customization
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'arcticicestudio/nord-vim'
"Plug 'xero/sourcerer.vim'
Plug 'dracula/vim', { 'as': 'dracula' }


"Language interpretation
Plug 'https://github.com/vim-syntastic/syntastic.git'

"Language client for neovim
"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh', }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf'

"ALE for error symbol in the left side symbol gutter
Plug 'w0rp/ale'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NerdTree
Plug 'preservim/nerdtree'

" Start screen
Plug 'mhinz/vim-startify'

" Note taking
Plug 'vimwiki/vimwiki'


" Initialize plugin system
call plug#end()


"Manual vim settings
set tabstop=2
set shiftwidth=2
set expandtab

"Enable line numbers
set number

"Enable mouse
set mouse=a

"No swap files
set noswapfile

" For VimWiki
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{'path': '/media/chuck/CORVID32/Chuck/wiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

set hlsearch

" Colors
let g:dracula_colorterm = 0
colorscheme dracula
let g:airline_powerline_fonts = 1

" Nerd Tree
nnoremap <leader>n :NERDTree<CR>
let g:NERDTreeHijackNetrw = 1
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif


" Folding
set foldmethod=syntax
hi Folded guibg=NONE
hi Folded ctermbg=NONE
hi Folded gui=NONE
hi Folded cterm=NONE
hi Type ctermbg=NONE
hi Comment ctermbg=NONE
hi RustDocComment ctermbg=NONE

function! MyFoldText()
  let sline = getline(v:foldstart)
  let eline = getline(v:foldend)
  let folded_line_num = v:foldend - v:foldstart
  let sline_text = substitute(sline, '^"{\+', '', 'g')
  let eline_text = substitute(eline, '^"\+}', '', 'g')
  let fline_text = '...' . folded_line_num . '...'
  let fillcharcount = &textwidth - len(sline_text) - len(eline_text) - len(fline_text)
  return sline_text . fline_text . eline_text . repeat(' ', fillcharcount)
endfunction

set foldtext=MyFoldText()

"Language client for vim (LanguageClient-neovim)
"====================================================================================
set hidden
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
set pumheight=20

"SignColumn Definition for ALE and Vim
"====================================================================================
let g:ale_sign_column_always = 1
highlight ALEErrorSign ctermfg=9 ctermbg=NONE guifg=#C30500 guibg=#F5F5F5
highlight ALEWarningSign ctermfg=11 ctermbg=NONE guifg=#ED6237 guibg=#F5F5F5
highlight SignColumn ctermbg=NONE

