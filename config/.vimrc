" https://superuser.com/questions/632657/how-to-setup-vim-to-edit-both-makefile-and-normal-code-files
execute pathogen#infect()

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

let g:airline_powerline_fonts = 1
" let g:solarized_termcolors=256
" change ack to ag
let g:ackprg = 'ag --vimgrep'

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
set t_Co=256

" toggle last search highlight
nnoremap <F3> :set hlsearch!<CR>

syntax enable
if has('gui_running')
    set background=light
    set columns=90
    set lines=40
    set go-=T
    set go-=r
    set guifont=Source\ Code\ Pro\ Regular\ 14
else
    set background=dark
endif
colorscheme solarized

filetype on
filetype plugin on
filetype indent on " filetype based intendation

" recognize anything in my .Postponed directory as a news article, and
" anything
" at all with a .txt extension as being human-language text [this clobbers
" the
" `help' filetype, but that doesn't seem to prevent help from working
" properly]:
augroup filetype
  autocmd BufNewFile,BufRead */.Postponed/* set filetype=mail
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

autocmd FileType mail set formatoptions+=t textwidth=72 " enable  wrapping in mail
autocmd FileType human set formatoptions-=t textwidth=0 " disable wrapping in txt
"
" for C-like  programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c,cpp,java set formatoptions+=ro
autocmd FileType c set omnifunc=ccomplete#Complete
" fixed indentation should be OK for XML and CSS. People have fast internet
" anyway. Indentation set to 2.
autocmd FileType html,xhtml,css,xml,xslt set shiftwidth=4 softtabstop=4

" two space indentation for some files
" autocmd FileType vim,lua,nginx set shiftwidth=2 softtabstop=2
" for CSS, also have things in braces indented:
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" add completion for xHTML
autocmd FileType xhtml,html set omnifunc=htmlcomplete#CompleteTags
" add completion for XML
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
" ensure normal tabs in assembly files
" and set to NASM syntax highlighting
autocmd FileType asm set noexpandtab shiftwidth=4 softtabstop=0 syntax=nasm

" нуменация строк
autocmd FileType asm,c,cpp,python set nu
" визуальное выделение последнего столбца
autocmd FileType asm,c,cpp,python,tex set cc=80
