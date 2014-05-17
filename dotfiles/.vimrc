execute pathogen#infect()
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufEnter *.wsgi, *.py set et ft=python
autocmd BufEnter *.md set ft=markdown
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
"autocmd FileType python set complete+=k~/.vim/syntax/python.vim  isk+=.,(
set nohlsearch
set rnu
set backspace=indent,eol,start
set smartindent
set autoindent 
set smarttab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set textwidth=79
set showmatch
set vb t_vb=
set ruler
set nohls
set incsearch 
set smartcase
filetype plugin indent on
syntax on
"let myfiletypefile = "$VIM/myFileTypes.vim"
"let mysyntaxfile = "$VIM/mySyntaxFile.vim"
"vmap <F2> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>
inoremap # X#
map <C-j> <C-w>j<C-w>_
map <C-k> <C-w>k<C-w>_
set wmh=0
"map <C-n> :set rnu!<cr>
nnoremap <silent> <C-n> :exec &nu==&rnu? "se nu!" : "se rnu!"<cr>

autocmd Filetype python map <F2> :map <F5> :!python %<lt>Enter><Enter>:echo "Python Mode"<Enter>
autocmd Filetype python map <F11> :map <F5> :!asmcomplinkload 
autocmd Filetype python map <F5> :echo "Normal Mode"<Enter>

"Let's be able to reload vimrc, please
map <F9> :so $MYVIMRC<Enter>:echo ".vimrc reloaded"<Enter>

"C++ bindings
autocmd Filetype cpp map <F5> :map <F5> :!compile_and_run_with_g++ % 
autocmd Filetype cpp map <F2> :map <F5> :!compile_and_run_with_g++ % 

"Ruby bindings
autocmd FileType ruby map <F5> :!ruby %<Enter>

"Python bindings
nnoremap <F2> :set nonumber!<Enter>:set foldcolumn=0<Enter>:set noai!<Enter>:set nosmartindent!<Enter>
"autocmd FileType python inoremap <Nul> <C-x><C-o>
autocmd FileType python map <F5> :!python %<Enter>
autocmd FileType python imap <C-space> <C-x><C-n>
"autocmd FileType python inoremap <C-space> <C-x><C-n>
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

"TODO: I really need to organize all this stuff out.

"TaskList
map <C-\>t :TaskList<cr>

"For inserting TODO comments
func! InsertTODO()
    if &filetype == 'python'
        echo "py"
        let commentchar="#"
    elseif &filetype == 'vim'
        echo "vimrc"
        let commentchar="\""
    elseif &filetype == 'basic'
        echo "vb"
        let commentchar="'"
    else
        let commentchar="//"
    endif

    call setline(line('.'), getline('.') . commentchar . 'TODO:  -W. Werner, ' . strftime("%Y-%m-%d"))
endfunc

"Rebind the command
func! RebindComment()
    imap <C-\>i x<Esc>"_x:call InsertTODO()<cr>f:la
endfunc

"Whenver we enter a new buffer
au BufEnter * call RebindComment()


"for hex files
nnoremap <C-H> :Hexmode<CR>
" Java Files
map <C-F12> :split ~/.vimrc<CR>:set modifiable<CR><C-j><C-k>
" For eclimd
autocmd FileType java map <F5> :w<CR>:Javac<CR>:Java<CR>
autocmd FileType java imap <C-space> <C-x><C-u>

" Lisp files
autocmd Filetype lisp map <F5> :w<CR>:!clisp %<CR>
autocmd Filetype lisp map <F6> :w<CR>:!clisp -repl %<CR>
autocmd Filetype lisp map <F7> :w<CR>:!clisp -c %<CR>
autocmd Filetype lisp map <F8> :!clisp<CR>

" VB files
autocmd BufEnter *.vb set filetype=basic

" For tags/scripture notes
autocmd BufWritePost /home/wayne/Dropbox/church/notes/* :helptags /home/wayne/Dropbox/church/notes
autocmd BufEnter /home/wayne/Dropbox/church/notes/* set tags +=/home/wayne/Dropbox/church/notes
autocmd BufLeave /home/wayne/Dropbox/church/notes/* set tags -=/home/wayne/Dropbox/church/notes
autocmd BufEnter /home/wayne/Dropbox/church/notes/* set ft=help
autocmd BufEnter /home/wayne/Dropbox/church/notes/* set iskeyword +=-
autocmd BufLeave /home/wayne/Dropbox/church/notes/* set iskeyword -=-

" For work stuff
autocmd BufWritePost $HOME/working/* :helptags $HOME/working
autocmd BufEnter $HOME/working/* set tags +=$HOME/working
autocmd BufLeave $HOME/working/* set tags -=$HOME/working
autocmd BufEnter $HOME/working/* set ft=help
autocmd BufEnter $HOME/working/* set iskeyword +=-
autocmd BufLeave $HOME/working/* set iskeyword -=-

" For notes
autocmd BufWritePost $HOME/notes/* :helptags $HOME/notes
autocmd BufEnter $HOME/notes/* set tags +=$HOME/notes
autocmd BufLeave $HOME/notes/* set tags -=$HOME/notes
autocmd BufEnter $HOME/notes/* set ft=help
autocmd BufEnter $HOME/notes/* set iskeyword +=-
autocmd BufLeave $HOME/notes/* set iskeyword -=-

" For minibuf explorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" for taglist and tasklist
let Tlist_Ctags_Cmd="/usr/bin/ctags"
map <C-l> :TaskList<cr>
map <C-p> :TlistToggle<cr>

color slate
syntax reset
"autocmd BufEnter *.py color blackboard
"autocmd BufLeave *.py color koehler
 
" Term title stuff
autocmd BufEnter * let &titlestring = "[vim(" . expand("%:t") . ")]"

" Set a ruler at column 80
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Turn off autowrap for (t)ext and (c)omments
set formatoptions-=tc

" Faster stronger
