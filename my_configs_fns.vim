"----------------------------------------
" Functions
"----------------------------------------
" Set number of spaces per tab
function! USetTabs(nspaces)
  let &tabstop=a:nspaces + 0
  let &shiftwidth=a:nspaces + 0
  set expandtab
  set lbr! 
endfunction

" Syntastic Aggregate errors Toggle
function! USyntasticAggregateErrors()
  if g:syntastic_aggregate_errors != 1
    echo "Enabling syntastic_aggregate_errors"
    let g:syntastic_aggregate_errors = 1
  else
    echo "Disabling syntastic_aggregate_errors"
    let g:syntastic_aggregate_errors = 0
  endif
endfunction

" Slimv
function! UToggleSlimv()
  let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"sbcl --load ~/.vim_runtime/sources_non_forked/slimv/slime/start-swank.lisp\""'
endfunction

" Mappings for YouCompleteMe
function! UToggleYCMMappings()
  if !exists("g:u_toggle_ycm") || g:u_toggle_ycm == 0
    nnoremap <C-c>g :YcmCompleter GoTo<CR>
    nnoremap <C-c>gd :YcmCompleter GoToDeclaration<CR>
    nnoremap <C-c>t :YcmCompleter GetType<CR>
    nnoremap <C-c>d :YcmCompleter GetDoc<CR>
    nnoremap <C-c>fi :YcmCompleter FixIt<CR>
    nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
    let b:ycm_reg_mappings = 1
    let g:ycm_global_ycm_extra_conf = "~/.vim_runtime/_ycm_extra_conf.py"
    let g:u_toggle_ycm = 1
    echo "Registering YCM mappings"
  endif
endfunction

" Java functions
" function! ULoadJavaRC()
"   let cfg = UFindConf('java.rc', '')
"   if exists("l:cfg") && cfg != ""
"     let binfolder = finddir('bin')
"     if binfolder ==# ''
"       echo "mkdir bin"
"       call mkdir('bin')
"     endif
"     let more_args = "-d bin"
"     for line in readfile(cfg, '')
"       let more_args = more_args.line
"     endfor
"     echo "Loaded conf: '".cfg."' => '".more_args."'"
"     let b:syntastic_scala_fsc_args =
"       \ get(g:, 'syntastic_scala_fsc_args', '') .
"       \ more_args
"   else
"     echo "'scala.rc not found'"
"   endif
" endfunction

" function! UToggleScala()
"   call ULoadScalaRC() 
" endfunction

" Mappings for Eclim
function! UToggleEclimMappings()
  if !exists("g:u_toggle_eclim") || g:u_toggle_eclim != 1
    let b:eclim_reg_mappings = 1
    " let g:EclimCompletionMethod = 'omnifunc' " Eclim
    if exists("*g:eclim#Enable")
      call eclim#Enable()
      nnoremap <C-c>i :JavaImport<CR>
      nnoremap <C-c>g :JavaSearchContext<CR>
      nnoremap <C-c>gd :JavaSearch -x declarations<CR>
      nnoremap <C-c>t :JavaSearch -x declarations<CR>
      nnoremap <C-c>fi :JavaCorrect<CR>
      nnoremap <C-c>d :JavaDocSearch -x declarations<CR>
      nnoremap <C-c>h :JavaHierarchy<CR>
      nnoremap <C-c>ch :JavaCallHierarchy<CR>
    endif
    let g:u_toggle_eclim = 1
    echo "Registering Eclim mappings"
  endif
endfunction

" Mappings for Pymode
function! UTogglePymodeMappings()
  if !exists("g:u_toggle_pymode") || g:u_toggle_pymode == 0
    let g:pymode = 1 " Turn on the whole plugin
    let g:pymode_warnings = 1 " Turn off plugin's warnings
    let g:pymode_paths = [] " Add paths to `sys.path`
    let g:pymode_trim_whitespaces = 1 " Trim unused white spaces on save
    let g:pymode_options = 1 " Setup default python options
    let g:pymode_python = 'python' " Values are `python`, `python3`, `disable`.
    echo "Registering pymode mappings"
  endif
endfunction

" Scala functions
function! ULoadScalaRC()
  let cfg = UFindConf('scala.rc', '')
  " findfile(\"scala.rc\", \".;\")
  if exists("l:cfg") && cfg != ""
    let binfolder = finddir('bin')
    if binfolder ==# ''
      echo "mkdir bin"
      call mkdir('bin')
    endif
    let more_args = "-d bin"
    for line in readfile(cfg, '')
      let more_args = more_args.line
    endfor
    echo "Loaded conf: '".cfg."' => '".more_args."'"
    let b:syntastic_scala_fsc_args =
      \ get(g:, 'syntastic_scala_fsc_args', '') .
      \ more_args
  else
    echo "'scala.rc not found'"
  endif
endfunction

function! UToggleScala()
  call ULoadScalaRC() 
endfunction

" Utility
function! UFindConf(what, where)
  let cfg = findfile(a:what, escape(a:where, ' ') . ';')
  return cfg !=# '' ? cfg : ''
endfunction
