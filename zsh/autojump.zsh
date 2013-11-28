#
# autojump init script
#
# author: Takayuki Kyowa
#
if [[ `uname` = "Darwin" && -f `brew --prefix`/etc/autojump ]]; then
  source `brew --prefix`/etc/autojump
fi
