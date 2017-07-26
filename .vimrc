" === PLUGINS ===
" Enable vim-plug
call plug#begin('~/.vim/plugged')

" vundle

Plug 'leafgarland/typescript-vim'
Plug 'gmarik/vundle'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'

Plug 'christoomey/vim-tmux-navigator'

Plug 'pangloss/vim-javascript'

Plug 'w0rp/ale'

Plug 'scrooloose/nerdcommenter'

Plug 'ervandew/supertab'

"Plug 'ternjs/tern_for_vim'
Plug 'Quramy/tsuquyomi'
Plug 'Valloric/YouCompleteMe'

Plug 'vimwiki/vimwiki'

call plug#end()

" === GENERAL SETTINGS ===

set number "Enable line numbers
set relativenumber " Set relative numbers on

set autoindent " Auto indent files
set smartindent " Use smart indent to indent

set tabstop=4 " tab == 4 spaces
set shiftwidth=4 " >>,<< move by 4 characters
set expandtab "expand tab into spaces
set undofile "use undo files
set incsearch hlsearch "highlight searches incrementally
set cursorline " Add cursor line
set lazyredraw "Does not update screen while executing macros etc
set ttyfast "Tells vim this is a fast terminal
set t_Co=256 "Use 256 colors

" === SYNTAX HIGHLIGHTING ===
syntax on
" Match parens
highlight MatchParen cterm=bold ctermbg=grey 
" Make comments grey
hi Comment ctermfg=darkgrey


" === CUSTOM COMMANDS AND KEYBINDINGS

" Set leader to ','
let mapleader = ","
" Replace previous functionality of '.' (backwards line search)
" with ';,'
nnoremap <leader>; ,

" Write and quit not case sensitive
ca W w 
ca Wq wq
ca Q q
ca Qa qa

" Switch panes with C-hjkl instead of C-w+hjkl
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" Remap d and x commands to NOT copy on delete
" Copy functionality can be acheived by prepending the leader
nnoremap <leader>d d
nnoremap <leader>x x
nnoremap d "_d
nnoremap x "_x

" === buffer commands ===
" ,ba = switch to alternate buffer
nmap <leader>ba :b#<cr>
" use ,bn and ,bp to cycle back and forth through buffers
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprev<cr>

" Who - display entire path for current file
command Who echo expand('%:p')
" Sub - Open current file in Sublime (for the non vim-savvy)
command Subl !echo '%:p' | xargs subl

" === MISCELLANEOUS ===

" Do not insert comments (on the line after a comment) when hitting enter etc.
autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable beeping on ESC
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

" Set clang_library_path
if has("unix")
    let s:uname = system("uname -s")
    "OSX ONLY"
    if s:uname == "Darwin"
        let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
    endif
endif

" Strip trailing whitespace for the given filetypes
autocmd FileType c,cpp,java,html,javascript,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" == PLUGIN SETTINGS ==

" === CTRL-P SETTINGS ===

" use nearest .git directory as working directory for ctrl-p
let g:ctrlp_working_path_mode = 'r'
set wildignore+=_site
set wildignore+=node_modules

" Activate ctrl-p with ',p'
nmap <leader>p :CtrlP<cr>

" ,bb = ctrp-p through buffers
nmap <leader>bb :CtrlPBuffer<cr> 
" ,bm = ctrp-p in mixed mode
nmap <leader>bm :CtrlPMixed<cr>
" ,bm = ctrl-p in most-recently-used mode
nmap <leader>bs :CtrlPMRU<cr>

" === VIM AIRLINE SETTINGS ===
" Enable powerline fonts and symbols
let g:airline_powerline_fonts = 1 
" Show all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
" Always show statusline
set laststatus=2


" === SYNTASTIC SETTINGS ===

" Populate location list
"  let g:syntastic_always_populate_loc_list = 1
"  " Do not automatically enable location list (this is SLOW)
"  let g:syntastic_auto_loc_list = 0
"  let g:syntastic_loc_list_height = 5
"  " Check files on open and save
"  let g:syntastic_check_on_open = 1
"  let g:syntastic_check_on_wq = 1
"  
"  " === Syntastic Linters  ===
"  let g:syntastic_javascript_checkers = ['eslint']
"  let g:syntastic_json_checkers=['jsonlint']
"  let g:syntastic_python_checkers=['flake8']
"  let g:syntastic_html_checkers=['polylint']

" === YOU COMPLETE ME SETTINGS ===
" let g:ycm_auto_trigger = 0
let g:ycm_autoclose_preview_window_after_completion = 1

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" === ALE SETTINGS ===

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'json': ['jsonlint'],
\   'python': ['flake8'],
\   'html': ['polylint'],
\   'typescript': ['tslint'],
\}

" === VIM-JAVASCRIPT SETTINGS ===

let g:javascript_plugin_jsdoc = 1



" === STATUS LINE ===

" === Add git status from fugitive
set statusline+=%{fugitive#statusline()}

" === Add linting status from Syntastic 
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*


" == Filetype specific settings ==

" === HTML ===
" Perform .html highlighting from the beginning of the file 
" (otherwise we get weird gaps in highlighting when there is 
" embedded javascript)
autocmd BufNewFile,BufRead,BufEnter *.html :syntax sync fromstart

" === JSON ===
" === Ensure json files are recognized as json files.
au BufRead,BufNewFile *.json set filetype=json
