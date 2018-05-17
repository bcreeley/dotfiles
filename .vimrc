call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'suan/vim-instant-markdown'
Plug 'bronson/vim-trailing-whitespace'
Plug 'majutsushi/tagbar'
call plug#end()

filetype plugin indent on

silent! colorscheme DarkDefault
hi clear CursorLine
hi CursorLine cterm=bold ctermbg=233

" Specify where new split occurs
set splitbelow
set splitright

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Turn on new-omni-completion
set omnifunc=syntaxcomplete#Complete

" Dark grey ruler at 81 character width
set colorcolumn=81
highlight ColorColumn ctermbg=233
set tw=80

" Show line numbers
set number
highlight LineNr ctermfg=233

" Stop vim from creating auto backup
set nobackup
set nowritebackup

