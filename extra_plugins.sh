#!/bin/bash

BASE=$PWD

# target_folder, gitcmd, fnc
function process() {
  target_folder=$1
  gitcmd=$2
  fnc=$3

  if [ ! -d $BASE/$target_folder ]; then
    echo "Cloning $target_folder"
    `$gitcmd $BASE/$target_folder`
  else
    echo "Updating $target_folder"
    cd $BASE/$target_folder
    git pull
  fi
  if [ -n "$fnc" ]; then
    $fnc
  fi
}

# git clone https://github.com/vim-scripts/WebAPI.vim.git sources_non_forked/WebAPI
process "sources_non_forked/WebAPI" "git clone https://github.com/vim-scripts/WebAPI.vim.git"

# C/C++ with YouCompleteMe
# git clone https://github.com/Valloric/YouCompleteMe.git sources_non_forked/YouCompleteMe
function ycm_install() {
  cd $BASE/sources_non_forked/YouCompleteMe
  git submodule update --init --recursive
  ./install.sh --clang-completer
  cd $BASE
}
#process "sources_non_forked/YouCompleteMe" "git clone https://github.com/Valloric/YouCompleteMe.git" "ycm_install"

# Lisp
# git clone https://github.com/kovisoft/slimv.git sources_non_forked/slimv
process "sources_non_forked/slimv" "git clone https://github.com/kovisoft/slimv.git"

# Latex
# git clone https://github.com/vim-latex/vim-latex.git sources_non_forked/vim-latex
process "sources_non_forked/vim-latex" "git clone https://github.com/vim-latex/vim-latex.git"

# Python
# git clone https://github.com/python-mode/python-mode sources_non_forked/python-mode
process "sources_non_forked/python-mode" "git clone https://github.com/python-mode/python-mode"

# Ultisnips
# git clone https://github.com/sirver/ultisnips sources_non_forked/ultisnips
process "sources_non_forked/ultisnips" "git clone https://github.com/sirver/ultisnips"

# Scala
# https://github.com/ensime/ensime-vim
process "sources_non_forked/ensime-vim" "git clone https://github.com/ensime/ensime-vim"
# https://github.com/derekwyatt/vim-scala
process "sources_non_forked/vim-scala" "git clone https://github.com/derekwyatt/vim-scala"
