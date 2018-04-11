#!/bin/sh

#
# Initial Directories
#
for dirname in bin etc local tmp downloads local/src local/bin local/Cellar
do
  mkdir -v -p ${HOME}/${dirname}
done

#
# RPM bulid directory
#
mkdir -v -p ${HOME}/.rpmbuild
for dirname in BUILD RPMS/x86_64 RPMS/noarch SOURCES SPECS SRPMS
do
  mkdir -v -p ${HOME}/.rpmbuild/${dirname}
done


#
# create symbolic links to dotfiles
#
for dotfile in `find ${HOME}/dotfiles/ -maxdepth 1 -mindepth 1  | grep -v -E '/\.' | grep -v 'toolbox' | grep -v 'setup.sh' | sort 2>/dev/null`
do
  basename=`basename ${dotfile}`
  from=${dotfile}
  dest=${HOME}/.${basename}

  #echo ${from} . ${dest}

  [[ -e ${dest} ]] && [[ ! -L ${dest} ]] && mv -v ${dest} ${dest}.back

  ln -sfvn ${from} ${dest}
done

#
# Vundle
#

# mkdir -p ~/.vim/bundle
# git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
# ${HOME}/dotfiles/.bin/vundle-install

#
# Brew
#

# brew install coreutils                                                                                         [/usr/local/share/tmux] <ruby 2.0.0p247 41674> [master]
