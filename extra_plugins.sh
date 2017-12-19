#!/bin/bash

BASE=$PWD

# target_folder, gitcmd, fnc
function process() {
  target_folder=$1
  gitcmd=$2
  fnc=$3

  cd $BASE

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

  echo ""
}

# git clone https://github.com/vim-scripts/WebAPI.vim.git sources_non_forked/WebAPI
process "sources_non_forked/WebAPI" "git clone https://github.com/vim-scripts/WebAPI.vim.git"

# C/C++ with YouCompleteMe
# git clone https://github.com/Valloric/YouCompleteMe.git sources_non_forked/YouCompleteMe
function ycm_install() {
  cd $BASE/sources_non_forked/YouCompleteMe
  git submodule update --init --recursive
  ./install.sh --clang-completer
}
process "sources_non_forked/YouCompleteMe" "git clone https://github.com/Valloric/YouCompleteMe.git" "ycm_install"

# Lisp
# git clone https://github.com/kovisoft/slimv.git sources_non_forked/slimv
process "sources_non_forked/slimv" "git clone https://github.com/kovisoft/slimv.git"

# Latex
# git clone https://github.com/vim-latex/vim-latex.git sources_non_forked/vim-latex
process "sources_non_forked/vim-latex" "git clone https://github.com/vim-latex/vim-latex.git"

# Python
# git clone https://github.com/python-mode/python-mode sources_non_forked/python-mode
process "sources_non_forked/python-mode" "git clone --recursive https://github.com/python-mode/python-mode"

# Ultisnips
# git clone https://github.com/sirver/ultisnips sources_non_forked/ultisnips
process "sources_non_forked/ultisnips" "git clone https://github.com/sirver/ultisnips"

#taglist
function taglist_install() {
  cd $BASE/sources_non_forked/taglist
  wget http://www.vim.org/scripts/download_script.php?src_id=19574 -O taglist.zip
  unzip taglist.zip -d $PWD
}
process "sources_non_forked/taglist" "mkdir -v " "taglist_install"

# Scala
# https://github.com/ensime/ensime-vim
# process "sources_non_forked/ensime-vim" "git clone https://github.com/ensime/ensime-vim"
# https://github.com/derekwyatt/vim-scala
process "sources_non_forked/vim-scala" "git clone https://github.com/derekwyatt/vim-scala"
