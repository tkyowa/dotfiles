set nocompatible
syntax on
let mapleader = ','

"=============================
" Vundle
"=============================

" --------------> filetype temporary disabled for Vundle(https://github.com/gmarik/vundle/blob/master/README.md)
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"Bundle 'gmarik/vundle'
Bundle 'vim-jp/vimdoc-ja'

if $SUDO_USER == ''
  Bundle 'Shougo/unite.vim'
  Bundle 'h1mesuke/unite-outline'
  Bundle 'Shougo/neocomplcache'
  Bundle 'Shougo/neocomplcache-snippets-complete'
endif

Bundle 'cakebaker/scss-syntax.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/gitv'
Bundle 'groenewege/vim-less'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'mattn/webapi-vim'
Bundle 'Raimondi/delimitMate'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/vimproc'
Bundle 'timcharper/textile.vim'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tsaleh/vim-matchit'
Bundle 'vim-ruby/vim-ruby'

Bundle 'bufman.vim'
Bundle 'svn-diff.vim'
Bundle 'surround.vim'
" Bundle 'YankRing.vim'
Bundle 'ZoomWin'

" unite-outlineを使うべし
"Bundle 'majutsushi/tagbar'
"Bundle 'taglist.vim'

"colorschemes
"Bundle 'jpo/vim-railscasts-theme'
"Bundle 'altercation/vim-colors-solarized'
"Bundle 'tomasr/molokai'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'Wombat'
Bundle 'wombat256.vim'
Bundle 'xoria256.vim'
"Bundle 'newspaper.vim'
"Bundle 'pyte'
"Bundle 'Lucius'
"Bundle 'mrkn256.vim'
"Bundle 'Zenburn'
"Bundle 'desert256.vim'
"Bundle 'inkpot'
"Bundle 'jellybeans.vim'
"Bundle 'synic.vim'
"Bundle 'chriskempson/vim-tomorrow-theme'

filetype plugin indent on
" <-------------- filetype enabled

"=============================
" Plugins
"=============================

"
" unite.vim
"
let g:unite_split_rule = 'topleft'  " デフォルトの画面分割ルールは上か左(botrightは逆)

" <C-h>がバッファローカルなマップで上書きされる（検索語削除）のを解除
autocmd FileType unite nnoremap <buffer> <C-h> <C-w>h

"
" unite-file_mru
"
" 最近使用したファイルの最大保存件数
let g:unite_source_file_mru_limit = 1000
"let g:unite_source_file_mru_time_format = '(%m/%d %H:%M) '
"let g:unite_source_file_mru_filename_format

"
" unite-grep
"
" let g:unite_source_grep_default_opts = '-Hn --color=never'
"" unite-grep {{{
" unite-grepのバックエンドをagに切り替える
" http://qiita.com/items/c8962f9325a5433dc50d
let g:unite_source_grep_command = 'ack'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200



" quick-matchの順番を1..9..a..zにする
let g:unite_quick_match_table = {
      \     '1' : 1, '2' : 2, '3' : 3, '4' : 4, '5' : 5, '6' : 6, '7' : 7, '8' : 8, '9' : 9, 'a' : 10,
      \     'b' : 11, 'c' : 12, 'd' : 13, 'e' : 14, 'f' : 15, 'g' : 16, 'h' : 17, 'i' : 18, 'j' : 19, 'k' : 20,
      \     'l' : 21, 'm' : 22, 'n' : 23, 'o' : 24, 'p' : 25, 'q' : 26, 'r' : 27, 's' : 28, 't' : 29, 'u' : 30,
      \ }

"
" neocomplcache
"

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" Enterでポップアップを閉じる
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"

" タブキーで補完
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ユーザ定義用のスニペットディレクトリ。カンマ区切りで複数指定できる。
let g:neocomplcache_snippets_dir = "~/.vim/snippets"

" 補完が自動で開始される文字数
let g:neocomplcache_auto_completion_start_length = 3

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダーバー)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 1

" スニペットのキーマッピング
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-n>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)


"
" NERD Tree
"

"http://blog.livedoor.jp/kumonopanya/archives/51048805.html

nnoremap <silent> <C-e> :<C-u>NERDTreeToggle<CR>
inoremap <silent> <C-e> <Esc>:NERDTree<CR>

nnoremap <Leader>ne :<C-u>NERDTreeToggle<CR>
nnoremap <Leader>nf :<C-u>NERDTreeFind<CR>
nnoremap <Leader>nb :<C-u>NERDTreeFromBookmark<Space>


" 引数なしでvimを起動した場合ツリーを開く
" diffを見るときとか標準入力から起動した場合でも表示しちゃうのでコメントアウト
"autocmd vimenter * if !argc() && len(getbufline("%", 1)) == 0 | NERDTree ./ | endif

" NERD Treeのみがバッファに残った場合はvimを閉じる
" ディレクトリを指定してvimを起動すると変な挙動になるのでコメントアウト
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q

let g:NERDTreeDirArrows  = 1      " ツリーの表示をシンプルに
let g:NERDTreeIgnore     = ['\.svn$', '\.clean$', '\.swp$', '\.swo$', '\.bak$', '\~$'] " 無視するファイル
let g:NERDTreeMinimalUI  = 1      " ブックマークやヘルプのショートカットを表示しない
let g:NERDTreeMouseMode  = 2      " ディレクトリはシングルクリック、ファイルはダブルクリックで開く
let g:NERDTreeShowHidden = 1      " 隠しファイルを表示する( I でtoggleできる)
let g:NERDTreeWinSize    = 31     " ツリーの幅
let g:NERDTreeWinPos     = "left" " ツリーの場所

"
" NERD Commenter
"

" コメントの間にスペースを空ける
let NERDSpaceDelims = 1

" 未対応なファイルタイプでエラーメッセージを表示しない
let NERDShutUp = 1

" noremapにするとなぜだか効かなくなる
nmap <Leader>m <Plug>NERDCommenterToggle
vmap <Leader>m <Plug>NERDCommenterToggle

"
" syntastic
"
let g:syntastic_enable_signs       = 1   " エラー行にサインをつける
let g:syntastic_auto_loc_list      = 1   " エラー発生時にエラーウィンドウ表示・エラー解消時にエラーウィンドウクローズ。
let g:syntastic_enable_balloons    = 1   " エラー時にバルーンポップ
let g:syntastic_echo_current_error = 1   " コマンド行にエラー内容を表示
let g:syntastic_auto_jump          = 0   " エラー行に自動でジャンプしない
let g:syntastic_loc_list_height    = 5   " エラーウィンドウの高さ
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['ruby'],
                           \ 'passive_filetypes': [] }

"
" PowerLine
"
" 独自のアイコンを使う（フォントにパッチを当てる必要がある）
let g:Powerline_symbols = 'fancy'

"
" taglist.vim
"
"let Tlist_Auto_Open = 1
let Tlist_Auto_Update = 1

"
" EasyMotion
"
let g:EasyMotion_leader_key = '<Leader>['
let g:EasyMotion_mapping_w = '<Leader><Leader>'
let g:EasyMotion_mapping_b = '<Leader>b'

"
" vim-quickrun
"
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}
" filetypeオプションは0.60devブランチのみ
let g:quickrun_config['ruby.rspec'] = {'command': 'spec', 'cmdopt': '--format specdoc', 'filetype': 'rspec-result'}

"
" ref.vim
"

" vimprocを使う
let g:ref_use_vimproc = 1

" 「,rr Enumerable inject」でrefeる
nnoremap <Leader>rr :<C-u>Ref refe<Space>

"
" YankRing.vim
"
let g:yankring_manual_clipboard_check = 0
let g:yankring_window_width = 40
let g:yankring_window_use_horiz = 0
let g:yankring_window_use_right = 0
nnoremap <Leader>yl :<C-u>YRShow<CR>
nnoremap <Leader>ys :<C-u>YRSearch<Space>
nnoremap <Leader>yr :<C-u>YRGetElem<Space>

"=============================
" Settings
"=============================

"
" 画面表示
"
set list listchars=tab:\ \ ,trail:_ " タブや改行を表示しない。行末の空白は表示する。
set number                          " 行番号の表示
set ruler                           " ルーラーを表示
set showmatch                       " 括弧入力時に対応する括弧を表示

"
" 検索
"
set ignorecase                      " 大文字・小文字を区別せず検索
set incsearch                       " インクリメンタルサーチ
set hlsearch                        " 検索結果をハイライト
set smartcase                       " 大文字・小文字の両方が含まれている区別して検索
set wrapscan                        " 検索時にファイルの最後まで行ったら最初に戻る

"
" インデント・タブ
"
set autoindent                      " 自動的にインデントする
set expandtab                       " タブをスペースに展開する
set shiftwidth=2
" set smartindent
" set smarttab
" set softtabstop=2
" set tabstop=2                       " タブの画面上での幅

"
" Folding
"
set nofoldenable                    " Foldingを無効化（unit-outlineを使うべし）
set foldmethod=manual               " Foldingを手動で作成する

"
" その他
"
set backspace=indent,eol,start      " バックスペースでインデントや改行を削除できるようにする(==backspace=2)
set clipboard=unnamed,autoselect    " yankとクリップボードを透過的に共有
set cmdheight=2                     " コマンド行の高さ
set diffopt=filler,vertical         " diffモードのデフォルトオプション
set formatoptions+=mM               " テキスト挿入中の自動折り返しを日本語に対応させる
set laststatus=2                    " 常にステータス行を表示
set nrformats=hex                   " Ctrl-a、Ctrl-xで値を増減させるときの認識方法(8進数は考慮しない)
set nobackup                        " バックアップファイルを作成しない
set noerrorbells
set noswapfile                      " スワップファイルを作成しない
set modelines=0                     " モードライン無効化
set showcmd                         " 入力中のコマンドをステータス行に表示
set title                           " タイトルを表示
set t_Co=256                        " 256色指定
set visualbell t_vb=                " ビープ音を無効化
set wrap                            " 長い行を折り返して表示
set wildmenu                        " 拡張モードのコマンドライン補完を有効にする
set whichwrap=h,l                   " 行頭・行末間移動を可能に

"Rubyのオムニ補完を設定(ft-ruby-omni)
"http://blog.blueblack.net/item_133
let g:rubycomplete_buffer_loading    = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails             = 1

"let g:netrw_liststyle=3            " 標準ファイラの表示をTree式に

"
" マウス
"
set mouse=a
set ttymouse=xterm2

"
" GUI
"
if has('gui')
  set antialias
  set guicursor=a:blinkon0 " カーソルの点滅をやめる
  set imdisable            " IMを無効化
  set showtabline=2        " タブを常に表示
  set transparency=5       " 透明度を指定

  " IMEが有効の時に色を変える
  "highlight CursorIM guifg=black guibg=red gui=NONE

  if has('gui_macvim')
    "set guifont=Ricty:h16
    set guifont=Ricty\ for\ Powerline:h16
  else
  endif
endif

"
" colorscheme
"
if has('gui_macvim')
  colorscheme xoria256
elseif has('gui_win32')
  colorscheme xoria256
elseif has('mac')
  colorscheme wombat256mod
elseif has('unix')
  colorscheme default
else
  colorscheme default
endif


"=============================
" autocmd
"=============================

" grepの検索結果が1件以上のときにquickfix-windowを開く
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep if len(getqflist()) != 0 | copen | endif
" set grepprg=ack\ -a

"
" FileType別の設定
"
" autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
" autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType perl       setlocal omnifunc=perlcomplete#Complete
" autocmd FileType php        setlocal omnifunc=phpcomplete#Complete
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType vim        setlocal omnifunc=vimcomplete#CompleteJS
" autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html       setlocal tabstop=4 softtabstop=4 shiftwidth=4 omnifunc=htmlcomplete#CompleteTags
" autocmd FileType make       setlocal tabstop=4 softtabstop=4 shiftwidth=4
" autocmd FileType c,cpp      setlocal tabstop=4 softtabstop=4 shiftwidth=4

" *.md を modula2 から markdown に上書き
autocmd BufNewFile,BufRead *.md set filetype=markdown

" show git diff when git commit(like svn-diff.vim)
autocmd FileType gitcommit DiffGitCached | only | split | buffer 1 | syntax on

" Rspecの複合ファイルタイプ定義
autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec

"=============================
" Key Bindings
"=============================

" Ctrl-sでセーブ(変更がある場合のみ)
nnoremap <C-s> :<C-u>update<CR>

" ,ub でunite-buffer + file_mru
nnoremap <silent> <Leader>ub :<C-u>Unite -buffer-name=files buffer_tab file_mru<CR>

" Ctrl-nでunite-buffer
nnoremap <silent> <C-n> :<C-u>Unite -buffer-name=files buffer_tab file_mru<CR>

" ,uo でunite-outline
nnoremap <silent> <Leader>uo :<C-u>Unite -direction=botright -winwidth=40 -no-quit -vertical -toggle outline<CR>

" ,uf でunite-file_mru
nnoremap <silent> <Leader>uf :<C-u>Unite file_mru<CR>

" ,g でunite-grep
nnoremap <silent> <Leader>g :<C-u>Unite -no-quit -direction=botright -buffer-name=search-buffer grep:.<CR>

" ,cg カーソル位置の単語をunite-grep
nnoremap <silent> <Leader>cg :<C-u>Unite -no-quit -direction=botright -buffer-name=search-buffer grep:.<CR><C-R><C-W><CR>

" Ctrl-iでヘルプ
nnoremap <C-i> :<C-u>help <C-r><C-w><CR>

" Ctrl-q 2度押しでカレントウィンドウを閉じる(GUI版のみ)
nnoremap <C-q><C-q> :<C-u>quit<CR>

" Ctrl-hjklでウィンドウ間移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ctrl-hjklでウィンドウ間移動
" inoremap <C-h> <LEFT>
" inoremap <C-j> <DOWN>
" inoremap <C-k> <UP>
" inoremap <C-l> <RIGHT>

" Terminal(putty)から送られてくる制御キー。たぶんOSによって違う。。
" http://unix.stackexchange.com/questions/1709/how-to-fix-ctrl-arrows-in-vim
map <ESC>[A <C-UP>
map <ESC>[B <C-DOWN>
map <ESC>[C <C-RIGHT>
map <ESC>[D <C-LEFT>
map! <ESC>[A <C-UP>
map! <ESC>[B <C-DOWN>
map! <ESC>[C <C-RIGHT>
map! <ESC>[D <C-LEFT>

" Ctrl-矢印でウィンドウの幅変更
nnoremap <C-UP> 2<C-W>+
nnoremap <C-DOWN> 2<C-W>-
" nnoremap <C-LEFT> 2<C-W><
" nnoremap <C-RIGHT> 2<C-w>>

" タブ操作
nnoremap <C-t> :<C-u>tabnew<CR>
nnoremap <C-RIGHT> :<C-u>tabnext<CR>
nnoremap <C-LEFT> :<C-u>tabprevious<CR>
"nnoremap <C-.> :tabnext<CR>
"nnoremap <C-,> :tabprevious<CR>
"nnoremap <C-1> 1gt
"nnoremap <C-2> 2gt

" 検索結果を画面の中央に表示
" http://q.hatena.ne.jp/1173854621
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" ESC連打でハイライトを消す
nmap <ESC><ESC> :<C-u>nohlsearch<CR><ESC>

" paste, nopasteの切り替え
" ステータスラインを redraw させるため pastetoggle ではなく invpaste を使用
nnoremap <silent> <Leader>p :<C-u>set invpaste<CR>

"対応する括弧に移動する。matchit.vimのmapを適用させる必要があるのでnoremapにはしないこと。
nmap ) %
nmap ( %


" 代替エスケープキー
inoremap <C-{> <ESC>
inoremap <C-;> <ESC>

" TODO:
"inoremap <C-,> <Home>
"inoremap <C-.> <End>

" shell風カーソル移動
inoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"<C-Space>でomni補完
"http://blog.blueblack.net/item_133
inoremap <C-Space> <C-x><C-o>

"<C-Space>で空白入力
nnoremap <Nul> i<Space><ESC><Right>

"エンターで改行入力
" nnoremap <CR> o<ESC>

" quickfix: 自動で編集許可と折り返し表示無効
function! OpenModifiableQF()
        cw
        set modifiable
        set nowrap
endfunction

autocmd QuickfixCmdPost vimgrep call OpenModifiableQF()

"=============================
" StatusLine
"=============================

" vim-powerlineに移行

""( [読込み専用] [編集有無] ) [ファイル名] [ヘルプ?]  |右寄せ| [ファイルタイプ] [文字コード] [現在行数/総行数]
"set statusline=%(%r%m%)\ %f\ %h\ %=\ [%{(&paste==0?'nopaste':'paste')}]\ %y\ %{'['.(&fenc!=''?&fenc:&enc).']'}\ [%l/%L]
"
"
"" ステータスラインのデフォルトカラー。背景色がグレーでフォントが白
"highlight StatusLine ctermfg=white ctermbg=DarkGray
"
""
"" 挿入モード時、ステータスラインの色を変更
"" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color#color-insertmode
""
"let g:hi_insert = 'highlight StatusLine ctermfg=Brown ctermbg=DarkGray'
"
"let s:slhlcmd = ''
"function! s:StatusLine(mode)
"  if a:mode == 'Enter'
"    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"    silent exec g:hi_insert
"  else
"    highlight clear StatusLine
"    silent exec s:slhlcmd
"  endif
"endfunction
"
"function! s:GetHighlight(hi)
"  redir => hl
"  exec 'highlight '.a:hi
"  redir END
"  let hl = substitute(hl, '[\r\n]', '', 'g')
"  let hl = substitute(hl, 'xxx', '', '')
"  return hl
"endfunction


"=============================
" Highlight
"=============================

" ポップアップメニューのカラー
highlight Pmenu      ctermbg=DarkGray  ctermfg=White guibg=#666666
highlight PmenuSel   ctermbg=LightBlue ctermfg=Black guibg=#8cd0d3 guifg=#666666
highlight PmenuSbar  ctermbg=White                   guibg=#333333
"highlight PmenuThumb

" 対応する括弧の背景色
highlight MatchParen ctermbg=DarkBlue


"=============================
" Custom Commands
"=============================

" Rakコマンド(標準のgrepを置き換える)
" set grepprg=rak\ --nocolour\ --nogroup
" command! -nargs=+ Rak execute 'silent grep! <args>' | copen 42 | redraw!

" vimrc再読み込み
command! -bar Reload source $MYVIMRC

" vimrc再読み込み + BundleInstall
command! -bar MyBundleInstall BundleInstall
command! -bar ReloadAndBundle Reload | MyBundleInstall | Reload | call cursor(1,1)

" 行末のスペース(空白)を除去
command! -bar CleanUpTrailingWhitespace %s/\s\+$//ge

" vimrcを開く
command! -bar Vimrc e ~/.vimrc


"=============================
" Misc
"=============================

"
" endwise.vim とneocomplcache でマップが競合している問題を解消するハック
" <CR> をアンマップしてから再定義している
" http://d.hatena.ne.jp/rhysd/20111010/1318264556
"
iunmap <CR>
imap <buffer> <expr><CR>
      \ pumvisible() ? neocomplcache#smart_close_popup()."\<CR>\<Plug>DiscretionaryEnd" : "\<CR>\<Plug>DiscretionaryEnd"



"
" load vimrc_local
"
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif

"
" load rspec-result.vim
"
if filereadable(expand('~/.vim/syntax/rspec-result.vim'))
  source ~/.vim/syntax/rspec-result.vim
endif


"=============================
" Tips
"=============================

" vimのカラースキームで使える色一覧
" http://fugal.net/vim/rgbtxt.html

"
" :helpgrep PATTERN
" :copen : helpgrepのヒット結果一覧を表示
" :ccl   : quickfix-windowを閉じる
" :cn    : 次のエラー箇所へジャンプ
" :cp    : 前のエラー箇所へジャンプ(:cNでも同じ)

"
" テキストオブジェクトの操作
" :h text-objects
" :h surround
"
" 'hogehoge-fugafuga'
"
" ''の中身を消す                : di'
" ''の中身を消してinsert-modeに : ci'
" ''の中身をyank                : yi'
" ''の中身を選択                : vi'
" 'を消す                       : ds'
" 'を"に変える                  : cs'"
" 行全体を"で囲う               : yss"
" カーソルから行末までを"で囲う : ys$"
" (viewで)<%= %>で囲う          : yss=
