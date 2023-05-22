
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Any valid git URL is allowed
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'vimwiki/vimwiki'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kaarmu/typst.vim'

"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh', }
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf'

" Initialize plugin system
call plug#end()


"#########################################################
"###                  CONFIGURATION                    ###
"#########################################################


"### File Encryption
"#########################################################
" let key_file = expand('~/.vim/vim.key')
" let plain_idr = "encryption: true"
" let cipher_idr = "VimCrypt"
" autocmd VimEnter,BufEnter *
"   \   if filereadable(key_file) && &filetype == 'vimwiki'
"   \ |   if search(plain_idr, 'p') == 1 || search(cipher_idr, 'p') == 1
"   \ |     execute 'set key=' . 'password'
"   \ |   endif
"   \ | endif

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

inoremap <expr> <cr>   coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <Down> coc#pum#visible() ? coc#pum#next(1)   : "\<Down>"
inoremap <expr> <Up>   coc#pum#visible() ? coc#pum#prev(1)   : "\<Up>"

"### VimWiki
"#########################################################
let g:vimwiki_list = [{'path': '~/wiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'custom'

let g:vimwiki_root_dir = '~/wiki'
noremap <Leader>wga :VimWikiGenerateAdjacencyGraph 1<CR>
noremap <Leader>wgg :VimWikiGenerateGraph


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

noremap <Leader>vt :vertical terminal<CR>
noremap <Leader>ht :terminal<CR>

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
  let l:lpadding = &fdc
  redir => l:signs
    execute "silent sign place buffer=".bufnr('%')
  redir end
  let l:padding += l:signs =~ 'id=' ? 2 : 0
  let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
  let l:end = substitute(substitute(getline(v:foldend), '\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')
  let l:info = ' (' . (v:foldend - v:foldstart). ') '
  let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
  let l:width = winwidth(0) - l:lpadding - l:infolen

  let l:separator = ' ... '
  let l:separatorlen = strlen(substitution(l:separator, '.', 'x', 'g'))
  let l:start = strpart(l:start, 0, l:width - strlen(substitute(l:end . '.', 'x', 'g')) - l:separatorlen)
  let l:text = l:start . l:separator . l:end

  return l:text . l:info . repeat(' ', l:width - strlen(substitute(l:text, '.', 'x', 'g')))
endfunction



"function! BuildGraph()
"  py3 /home/chuck/Documents/md-graph/md-graph.py ~/wiki/config.json
"endfunction
"command! VimWikiBuildGraph call BuildGraph()


