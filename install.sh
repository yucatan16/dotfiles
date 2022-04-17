#!/usr/bin/env bash

if [ ! -d $HOME/.zsh/completions ]; then
  mkdir -p $HOME/.zsh/completions
  cd ~/.zsh/completions
  wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
  wget -O _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh 
fi

set -eux

for f in $(find . -name '.*' -maxdepth 1 -not -name '.git' | grep -v '^.$' ); do
    n=$(basename ${f})
    src=$(pwd)/${n}
    dist=${HOME}/${n}
    ln -snf ${src} ${dist}
done