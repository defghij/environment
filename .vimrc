
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Any valid git URL is allowed
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tpope/vim-obsession'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'vimwiki/vimwiki'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-syntastic/syntastic'

"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh', }
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf'

" Initialize plugin system
call plug#end()


"#########################################################
"###                  CONFIGURATION                    ###
"#########################################################


"### Scratch
"#########################################################

command Scratch setl buftype=nofile bufhidden=hide noswapfile
command ScratchWin :new +Scratch
command ScratchTab :tabnew +Scratch

" This buffer is not a s[c]ratch buffer
noremap <C-C><C-P> :Scratch<CR>

" Create a new s[c]ratch [w]indow
noremap <C-C><C-W> :ScratchWin<CR>

" Create a new s[c]ratch [t]ab
noremap <C-C><C-T> :ScratchTab<CR>


"### Language client for vim (LanguageClient-neovim)
"#########################################################
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>ShowDocumentation()<CR>

"### VimWiki
"#########################################################
let g:vimwiki_list = [{'path': '~/wiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'custom'


"### Nerdtree
"#########################################################
nnoremap <leader>n :NERDTree<CR>
let g:NERDTreeHijackNetrw = 1
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif


"### Basic configuration
"#########################################################
set tabstop=2
set shiftwidth=2
set expandtab
set number
set mouse=a
set noswapfile
set listchars=tab:>-
set virtualedit=all
set cursorline
set hlsearch
set autoread

command Reload :source ~/.vimrc

set viewoptions-=options

if has("folding") || (&filetype == 'vimwiki')
  set foldenable
  set foldmethod=syntax
  set foldlevelstart=99
  set foldtext=FoldText()
  let g:markdown_folding = 1
  let g:markdown_enable_folding = 1

  nnoremap <Space> za
  nnoremap <expr> zz &foldlevel != 0 ? 'zM' : 'zR'
endif

"#### Highlights and colors
"#########################################################

hi Folded guibg=NONE
hi Folded ctermbg=NONE
hi Folded gui=NONE
hi Folded cterm=NONE
hi Type ctermbg=NONE
hi Comment ctermbg=NONE
hi RustDocComment ctermbg=NONE
source ~/.vim/sourcerer.vim

" Spelling
setlocal spell
set spelllang=nl,en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u


"### Functions
"#########################################################

function! FoldText()
  let sline = getline(v:foldstart)
  let eline = getline(v:foldend)
  let folded_line_num = v:foldend - v:foldstart
  let sline_text = substitute(sline, '^"{\+', '', 'g')
  let eline_text = substitute(eline, '^"\+}', '', 'g')
  let fline_text = '...' . folded_line_num . '...'
  let fillcharcount = &textwidth - len(sline_text) - len(eline_text) - len(fline_text)
  return sline_text . fline_text . eline_text . repeat(' ', fillcharcount)
endfunction




