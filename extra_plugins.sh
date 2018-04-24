#!/bin/bash

function USAGE() {
  echo -e "$0 <option>.\nThis script installs several plugins."
  echo "<option> can be:"
  echo -e "\t-i : Interactive mode will ask if you want or not to try to install each plugin"
  echo -e "\t-y : Install all the plugins without asking."
  echo -e "\t-n : Dry run of the script (Doesn't install anything)."
}

if [ "$#" -lt 1 ]; then
  USAGE;
  exit -1;
fi

OPTION=$1
DRY=""
INTERACTIVE=""
if [ "$OPTION" == "-i" ]; then
  INTERACTIVE="1"
elif [ "$OPTION" == "-y" ]; then
  INTERACTIVE="0"
elif [ "$OPTION" == "-n" ]; then
  DRY="echo "
else
  USAGE;
  exit -1;
fi

BASE=$PWD

function process() {
  # target_folder, clone_cmd, update_cmd, fnc
  # - target_folder: what folder to create and where
  # - clone_cmd: what command to run to get the data. It can be 'git clone...' or 'mkdir...'
  # - update_cmd: what command to run to get update the data. It can be 'git pull...'
  # - fnc: lambda function to execute after performing the clone_cmd or update_cmd
  target_folder=$1
  clone_cmd=$2
  update_cmd=$3
  fnc=$4

  if [ "$INTERACTIVE" == "1" ]; then
    read -p "Do you want to run '$1' (y/n)?" ANSWER
    if [ "$ANSWER" != "y" ]; then
      echo "Skipping..."
      return 0
    fi
  fi

  $DRY cd $BASE

  if [ ! -d $BASE/$target_folder ]; then
    echo "Cloning $target_folder"
    $DRY $clone_cmd $BASE/$target_folder
  else
    echo "Updating $target_folder"
    $DRY cd $BASE/$target_folder
    $DRY $update_cmd
  fi
  if [ -n "$fnc" ]; then
    echo "Executing lambda function '$fnc'"
    $DRY $fnc
  fi

  echo ""
}

# git clone https://github.com/vim-scripts/WebAPI.vim.git sources_non_forked/WebAPI
process "sources_non_forked/WebAPI" "git clone https://github.com/vim-scripts/WebAPI.vim.git" "git pull"

# C/C++ with YouCompleteMe
# git clone https://github.com/Valloric/YouCompleteMe.git sources_non_forked/YouCompleteMe
function ycm_install() {
  cd $BASE/sources_non_forked/YouCompleteMe
  git submodule update --init --recursive
  ./install.sh --clang-completer
}
process "sources_non_forked/YouCompleteMe" "git clone https://github.com/Valloric/YouCompleteMe.git" "git pull" "ycm_install"

# Lisp
# git clone https://github.com/kovisoft/slimv.git sources_non_forked/slimv
process "sources_non_forked/slimv" "git clone https://github.com/kovisoft/slimv.git" "git pull"

# Latex
# git clone https://github.com/vim-latex/vim-latex.git sources_non_forked/vim-latex
process "sources_non_forked/vim-latex" "git clone https://github.com/vim-latex/vim-latex.git" "git pull"

# Python
# git clone https://github.com/python-mode/python-mode sources_non_forked/python-mode
process "sources_non_forked/python-mode" "git clone --recursive https://github.com/python-mode/python-mode" "git pull"

# Ultisnips
# git clone https://github.com/sirver/ultisnips sources_non_forked/ultisnips
process "sources_non_forked/ultisnips" "git clone https://github.com/sirver/ultisnips" "git pull"

#taglist
function taglist_install() {
  cd $BASE/sources_non_forked/taglist
  wget http://www.vim.org/scripts/download_script.php?src_id=19574 -O taglist.zip
  unzip taglist.zip -d $PWD
}
process "sources_non_forked/taglist" "mkdir -v " "echo NOOP" "taglist_install"

# Scala
# https://github.com/ensime/ensime-vim
# process "sources_non_forked/ensime-vim" "git clone https://github.com/ensime/ensime-vim"
# https://github.com/derekwyatt/vim-scala
process "sources_non_forked/vim-scala" "git clone https://github.com/derekwyatt/vim-scala" "git pull"

# Ginger grammar check
function ginger_install() {
  cd $BASE/sources_non_forked/ginger-vim/plugin
  wget https://gist.githubusercontent.com/spino327/1896cad258a6dd956edf597c6960d886/raw/ac5ab0c33579b4bbbe42dfd87527a04f0613b9c3/ginger.vim -O ginger.vim
}
process "sources_non_forked/ginger-vim/plugin" "mkdir -vp " "echo NOOP" "ginger_install"


