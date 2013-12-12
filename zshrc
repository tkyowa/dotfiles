#
# zshrc
#
# Supported Linux and Mac OS X.
# OS X requirement coreutils. (install by homebrew, don't override standard utils!).
#

HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

fpath=(${HOME}/.zsh/functions ${fpath})
autoload -U compinit
compinit -u

autoload colors
colors

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

#=============================
# Environments
#=============================

export LANG=ja_JP.UTF-8
export TMP="${HOME}/tmp"

#
# PATH
#
if [ -z `echo ${PATH} | grep ${HOME}/local/bin` ]; then
  export PATH=${HOME}/local/bin:${PATH}
  export PATH=${HOME}/bin:${PATH}
  export PATH=${HOME}/.bin:${PATH}
fi

# coreutils
if [[ `uname` = "Darwin" ]]; then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

#
# coreutils
#
export PAGER="/usr/bin/less"
export EDITOR="vim"
#export GREP_OPTIONS="--color=auto --recursive --binary-files=without-match --exclude-dir=\.svn --exclude-dir=\.git"
export GREP_OPTIONS="--color=auto --binary-files=without-match"
export LESS='--RAW-CONTROL-CHARS --LONG-PROMPT --tabs=8 --silent'
if [[ `uname` = "Darwin" && -f /usr/local/bin/src-hilite-lesspipe.sh ]] ; then
  export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

#
# ruby
# http://doc.ruby-lang.org/ja/1.8.7/doc/spec=2fenvvars.html
#
export RUBYOPT=rubygems

#
# subversion
#
export SVN_EDITOR="${EDITOR}"


#=============================
# Key Bindings
#=============================

# Emacs風キーバインド設定
bindkey -e

# history search
bindkey '^P' history-beginning-search-backward
#bindkey '^R' history-incremental-pattern-search-backward
#bindkey '^S' history-incremental-pattern-search-forward

bindkey "^[[1~" beginning-of-line     # [HOME] 行頭へ移動
bindkey "^[[4~" end-of-line           # [END]  行末へ移動
bindkey "^[[3~" delete-char           # [DEL]  文字を削除
bindkey "\e[Z" reverse-menu-complete  #        逆方向の補完


#=============================
# Aliases
#=============================

#
# Global
#
alias -g G=' 2>&1 | grep'
alias -g GI=' 2>&1 | grep -i'
alias -g GL=' 2>&1 | grep --color=always'
alias -g GV=' 2>&1 | grep -v'
alias -g H='| head'
alias -g L='| less'
alias -g P='--help'
alias -g HELP='--help | less'
alias -g S='| sort'
alias -g T='| tail'
alias -g V='| vim -R -'
alias -g be='bundle exec'
alias -g bi='bundle install'

#
# Alias of 1 character
#
# alias a= # reserved on local
alias a='ack'
alias b='bundle'
alias c='rails console --debugger'
alias d='git diff --check HEAD'
alias e='vim'
alias g='git'
alias i='irb'
alias l='ll'
alias r='rails'
alias s='svn'


#
# Shell
#
if [[ `uname` = "Darwin" ]] ; then
  alias ls='gls --color=auto'
  alias dircolors='gdircolors'
else
  alias ls='ls --color=auto'
fi
alias puts="echo"
alias ll='ls -lh --time-style=long-iso'
alias vi='vim'
alias du='du -m'
alias du-sorted='/usr/bin/du -sm * | sort -rn'
alias df='df -h'
alias top="top -c"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

#
# git
#
alias st="git status -sb"
alias ci="git commit"
alias log="git log"

#
# RPM
#
alias rpm-query='rpm -qa'
alias rpm-find-package='rpm -qf'
alias rpm-file-list='rpm -ql'
alias rpm-file-list-local='rpm -qpl'

#
# dstat
#
alias dstat-full='dstat -Tclmdrn'
alias dstat-mem='dstat -Tclm'
alias dstat-cpu='dstat -Tclr'
alias dstat-net='dstat -Tclnd'
alias dstat-disk='dstat -Tcldr'

#
# sar
#
alias sar-full='sar -A'
alias sar-cpu-all='sar -P ALL'
alias sar-load-average='sar -q'
alias sar-memory='sar -r'
alias sar-io='sar -b'

#
# lsof
#
alias lsof-ports="lsof -i4 -n -P"

#
# Ruby
#
alias ruby-oneliner='ruby -rpp -e'
alias ruby-oneliner-each='ruby -rpp -n -e'
alias ruby-oneliner-inplace='ruby -rpp -i -p -e'
alias rake='rake -g'
alias con='script/console'
alias pry-console='pry -r config/environment'
alias spec='spec -c'

#
# Setting files
#
alias reload='source ~/.zshrc'
alias e-zsh='vi ~/.zshrc'
alias e-screen='vi ~/.screenrc'
alias e-bash='vi ~/.bashrc'
alias e-vi='vi ~/.vimrc'
alias e-vim='vi ~/.vimrc'
alias e-irb='vi ~/.irbrc'
alias e-rvm='vi ~/.rvmrc'
alias e-rdebug='vi ~/.rdebugrc'

#
# Setting files(local)
#
alias e-bash-local='vi ~/.bashrc_local'
alias e-zsh-local='vi ~/.zshrc_local'
alias e-vim-local='vi ~/.vimrc_local'

#
# Suffix Alias
#
alias -s bz2='extract'
alias -s gz='extract'
alias -s tar='extract'
alias -s tgz='extract'
alias -s xz='extract'
alias -s zip='extract'


#=============================
# Prompt
#=============================

# format
# http://zsh.sourceforge.net/Doc/Release/zsh_12.html#SEC40
# 詳細は man zshmisc を参照
#
# %% %を表示
# %) )を表示
# %l ホスト名
# %M ホスト名(FQDN)
# %m ホスト名(サブドメイン)
# %n ユーザー名
# %y 端末名
# %# rootなら#、他は%を表示
# %? 直前に実行したコマンドの結果コード
# %d ワーキングディレクトリ %/ でも可
# %~ ホームディレクトリからのパス
# %h ヒストリ番号 %! でも可
# %a The observed action, i.e. "logged on" or "logged off".
# %S (%s) 反転モードの開始/終了 %S abc %s とするとabcが反転
# %U (%u) 下線モードの開始/終了 %U abc %u とするとabcに下線
# %B (%b) 強調モードの開始/終了 %B abc %b とするとabcを強調
# %t 時刻表示(12時間単位、午前/午後つき) %@ でも可
# %T 時刻表示(24時間表示)
# %* 時刻表示(24時間表示秒付き)
# %w 日表示(dd) 日本語だと 曜日 日
# %W 年月日表示(mm/dd/yy)
# %D 年月日表示(yy-mm-dd)"

local GREEN=$'%{\e[1;32m%}'
local LIGHTBLUE=$'%{\e[1;34m%}'
local LIGHTRED=$'%{\e[1;31m%}'
local WHITE=$'%{\e[1;37m%}'
local DEFAULT=$'%{\e[00;m]%}'

# change prompt color when as root
case ${UID} in
  0)
    local BASECOLOR=${LIGHTRED}
    ;;
  *)
    local BASECOLOR=$'%{\e[38;5;31m%}'
    ;;
esac

# Ruby version for Propmpt
# rvm          ->  rvm-1.8.7-p352
# ruby(system) -> ruby-1.8.7-p352
function ruby_prompt {
  result=`rvm-prompt rvm- v p 2> /dev/null`
  if [ "$result" ] ; then
    echo " <$result>"
  else
    echo "<`ruby -v | cut -d ' ' -f 1,2,5 | sed -e 's/)//' | sed -e 's/\s/-/' | sed -e 's/\s/-p/'`>"
  fi
}

local RUBY_COLOR=$'%{\e[38;5;31m%}'
local USER_NAME_COLOR=$'%{\e[38;5;199m%}'
local HOST_NAME_COLOR=$'%{\e[38;5;190m%}'
local PATH_COLOR=$'%{\e[38;5;61m%}'
local VCS_COLOR=$'%{\e[38;5;248m%}'

RUBY_INFO=$'%{$PATH_COLOR%}$(ruby_prompt)%{${reset_color}%}'

# 左側に表示されるの通常のプロンプト
PROMPT="%{$BASECOLOR%}%n@%m %(!.#.$) %{${reset_color}%}"

# 2行でリッチなやつ
#PROMPT="%{$fg[cyan]%}%n%{$fg[white]%}@%{$fg[green]%}%m%{$fg[white]%}:%{$fg[yellow]%}%~ $(echo ${RUBY_INFO}) %1(v|%F{green}%1v%f|)
#%{$fg[white]%}%(!.#.$)%{${reset_color}%} "

# 右側に表示されるプロンプト。入力が被ると自動的に消える。
RPROMPT="%{$BASECOLOR%}[%~]%{${reset_color}%} $(echo ${RUBY_INFO}) %1(v|%F{green}%1v%f|)"

# 2行以上のコマンドを入力する際に表示されるプロンプト。
PROMPT2="%{$BASECOLOR%}%_> %{${reset_color}%}"

# コマンドを打ち間違えたときの「もしかして」プロンプト。
SPROMPT="%{$BASECOLOR%}correct: %R -> %r [nyae]? %{${reset_color}%}"

#=============================
# Functions
#=============================

# 全履歴の一覧を出力する
function history-all { history -E 1 }

# ある文字列を含む直近の履歴を grep する。
function history-grep { history -E 1 | grep $1 | tail }

# 256色確認
function pcolor() {
    for ((f = 0; f < 255; f++)); do
        printf "\e[38;5;%dm %3d*■\e[m" $f $f
        if [[ $f%8 -eq 7 ]] then
            printf "\n"
        fi
        done
    echo
}

# アーカイブの展開
function extract(){
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar jxf $1    ;;
          *.tar.gz)    tar zxf $1    ;;
          *.tar.xz)    tar Jxf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xf $1     ;;
          *.tbz2)      tar jxf $1    ;;
          *.tgz)       tar zxf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.lzma)      lzma -dv $1    ;;
          *.xz)        xz -dv $1      ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

function zvim(){
  zcat $1 V
}

# e.g. svn-ignore something_new_file ./
function svn-ignore() {
  svn pset svn:ignore -F <(echo $1 && svn pget svn:ignore | sed '/^$/d') $2
}

# show rvm prompt like "1.9.2@gemset_name"
function rvm_prompt() {
  result=`rvm-prompt v g 2> /dev/null`
  if [ "$result" ] ; then
    echo "[$result]"
  fi
}

function underscore() {
  eval "ruby -rrubygems -e 'require \"active_support/all\"; puts \"$1\".underscore'"
}

function classify() {
  eval "ruby -rrubygems -e 'require \"active_support/all\"; puts \"$1\".classify'"
}


#=============================
# Options
#=============================

limit     coredumpsize 1002400    # コアダンプサイズを制限
setopt    autopushd               # cd 時に自動で pushd
setopt    append_history          # 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt    auto_cd                 # ディレクトリ名だけで cd
#unsetopt auto_list               # 補完候補を一覧表示しない
unsetopt  auto_menu               # tab で補完候補一覧から選択しない TODO:tab では選択しないが、Ctrl+Iでは選択するような事をしたい。
setopt    auto_param_keys         # カッコの対応などを自動的に補完
setopt    auto_param_slash        # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
#setopt   auto_resume             # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
#setopt   correct                 # 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt    complete_aliases
setopt    complete_in_word        # 語の途中で補完する。(e.g. fbarのbに合わせてTABでfoobarとなる)
#setopt   equals                  # =command を command のパス名に展開する
#setopt   extended_history         # ヒストリファイルに実行時刻(エポックからの秒数)と実行時間(秒)も保存する。
unsetopt  extended_glob           # ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt    hist_ignore_dups        # 直前と同じコマンドをヒストリに追加しない
setopt    hist_ignore_space       # 先頭がスペースならヒストリーに追加しない。
#setopt   hist_verify             # ヒストリを呼び出してから実行する間に一旦編集
setopt    ignoreeof               # Ctrl-D(^D)でログアウトしない。
setopt    interactive_comments    # コメントを有効にする。(#以下が対象になる)
setopt    list_packed             # 補完候補を詰めて表示
#setopt   long_list_jobs          # 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt    magic_equal_subst       # --prefix=/usr などの = 以降も補完
setopt    nobeep                  # ビープを鳴らさない
setopt    nohup                   # ターミナルを閉じてもプロセスをKillしないように。
setopt    no_tify                 # バックグラウンドジョブが終了したらすぐに知らせる。
setopt    print_eightbit          # 自動補完リストなどで日本語を表示できるように。
setopt    prompt_subst            # PROMPT内で変数展開・コマンド置換・算術演算を実行する
setopt    prompt_percent          # PROMPT内で「%」文字から始まる置換機能を有効にする。
unsetopt  promptcr                # 出力の文字列末尾に改行コードが無い場合でも表示
setopt    pushd_ignore_dups       # 同じディレクトリを pushd しない
setopt    rm_star_wait            # rm * を実行する前に確認する。
setopt    share_history           # シェルのプロセスごとに履歴を共有
setopt    transient_rprompt       # コマンド実行後は右プロンプトを消す。

#=============================
# ZStyle
#=============================

# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

# ファイル補完候補に色づけ
eval `dircolors -b ${COLORS}`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 補完で大文字小文字の区別をしない。(ただし、大文字の時は小文字を補完しない。）
# http://wiki.fdiary.net/zsh/?FAQ%40zsh%A5%B9%A5%EC#l12
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#=============================
# Others
#=============================

# フロー制御の無効化
#  http://blog.clouder.jp/archives/000661.html
stty stop undef

# ターミナルのタイトルに「ユーザ@ホスト:カレントディレクトリ」を表示させる。
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# screenの自動起動
# http://www.callcc.net/diary/20040706.html
# http://www.q-eng.imat.eng.osaka-cu.ac.jp/~ippei/unix/#l12
# http://www.shandygaff.net/mt/2006/10/screen_1.html
if [ $TERM != 'screen' ];then
  if [ $SHLVL = 1 ];then
    screen -xR
  fi
fi

#
# screenのステータスラインに各ウィンドウで最後に実行したコマンドを表示
# http://hatena.g.hatena.ne.jp/hatenatech/20060517
#
if [ -n $STY ]; then
  preexec() {
    # see [zsh-workers:13180]
    # http://www.zsh.org/mla/workers/2000/msg03993.html
    emulate -L zsh
    local -a cmd; cmd=(${(z)2})
    echo -n "k$cmd[1]:t\\"
  }
fi

#=============================
# Externals
#=============================

# rvm
# [[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"

# git completion
# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
[[ -f "${HOME}/.zsh/git-completion.bash" ]] && source ${HOME}/.zsh/git-completion.bash

# autojump
[[ -f "${HOME}/.zsh/autojump.zsh" ]] && source ${HOME}/.zsh/autojump.zsh

# auto-fu
# https://github.com/hchbaw/auto-fu.zsh
#if [[ -f "${HOME}/.zsh/auto-fu.zsh" ]]; then
#  source ~/.zsh/auto-fu.zsh
#  zle-line-init () {auto-fu-init;}
#  zle -N zle-line-init
#  zstyle ':completion:*' completer _oldlist _complete
#  zle -N zle-keymap-select auto-fu-zle-keymap-select
#fi

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# zsh local
[[ -f ${HOME}/.zshrc_local ]] && source ${HOME}/.zshrc_local
