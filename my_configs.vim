
"----------------------------------------
" General
"----------------------------------------
syntax on
set number
set printoptions=number:y
set mouse=a
let g:NERDTreeWinPos = "left"

"----------------------------------------
" Omni completion
"----------------------------------------
filetype plugin on
filetype indent on
set omnifunc=syntaxcomplete#Complete

"----------------------------------------
" Functions
"----------------------------------------
source ~/.vim_runtime/my_configs_fns.vim

"----------------------------------------
" Tabs
"----------------------------------------
" set tabstop=2
" set shiftwidth=2
" set expandtab
" set lbr! 
call USetTabs(2)

"----------------------------------------
" Grep
"----------------------------------------
set grepprg=/usr/bin/grep\ -nH\ $*

"----------------------------------------
" set background=light
"----------------------------------------
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme evening
endif

"----------------------------------------
" Dictionary
"----------------------------------------
set dictionary+=/usr/share/dict/words

"----------------------------------------
" Tex-vim
"----------------------------------------
" let g:Tex_TreatMacViewerAsUNIX = "1"
let g:Tex_ViewRule_pdf = "skim"
let g:Tex_MultipleCompileFormats="dvi,pdf"

"----------------------------------------
" syntastics
"----------------------------------------
let g:syntastic_tex_checkers = ['lacheck', 'chktex', 'proselint']
let g:syntastic_scala_checkers = ['fsc', 'scalastyle']

"----------------------------------------
"----------------------------------------
" Development
"----------------------------------------
"----------------------------------------
" Taglist 
"----------------------------------------
nnoremap <C-c>tl :Tlist<CR>

"----------------------------------------
" slimv
"----------------------------------------
let g:lisp_rainbow=1 
" let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"sbcl --load ~/.vim_runtime/sources_non_forked/slimv/slime/start-swank.lisp\""'
autocmd BufRead *.lisp call UToggleSlimv() 

"----------------------------------------
" YouCompleteMe
"----------------------------------------
" let g:ycm_global_ycm_extra_conf = "~/.vim_runtime/_ycm_extra_conf.py"
autocmd BufRead *.c,*.cpp,*.h call UToggleYCMMappings()

"----------------------------------------
" Python-mode
"----------------------------------------
" let g:pymode_rope=0
" let g:pymode_rope_lookup_project = 0
" let g:pymode_rope_complete_on_dot = 0
autocmd BufRead *.py call UTogglePymodeMappings()

"----------------------------------------
" Java - Eclim
"----------------------------------------
let g:EclimCompletionMethod = 'omnifunc'
autocmd BufRead *.java call UToggleEclimMappings()


"----------------------------------------
" Scala
"----------------------------------------
autocmd BufRead *.scala call UToggleScala()

"----------------------------------------
" Ultisnips
"----------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" <C-tab>      
let g:UltiSnipsExpandTrigger="<C-c>s"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
