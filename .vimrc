call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'suan/vim-instant-markdown'
call plug#end()

filetype plugin indent on

silent! colorscheme DarkDefault
hi clear CursorLine
hi CursorLine cterm=bold ctermbg=233

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

" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

