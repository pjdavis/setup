" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'universal-ctags/ctags'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'atom/fuzzy-finder'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'wincent/command-t', {
			\ 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
			\	}

" Initialize plugin system
call plug#end()

let g:neocomplete#enable_at_startup = 1

" Show linenumbers
set number
set ruler

let g:elite_mode=1

"""""""""""""""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
nmap ,f :FufFileWithCurrentBufferDir<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>

set splitbelow

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()
autocmd FileType gitcommit setlocal spell

runtime macros/matchit.vim
if has("autocmd")
	filetype indent plugin on
endif
