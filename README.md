djslyr_core
===========

ダジャレ殺すべし

Finding Dajares (puns) in your input text.

Install
--------

Require MeCab

```
$ brew install mecab mecab-ipadic
$ mecab -v # mecab of 0.996
```

Clone this project.

```
$ git clone https://github.com/hackugyo/djslyr_core.git
$ cd djslyr_core
$ bundle install
```

Usage
--------

```
$ ruby djslyr.rb '琉球で有給'
OR
$ ruby djslyr.rb -i ダジャレ.txt
```

TODO
--------

* 元の入力文のどこがダジャレになっているかを表示する（現状は読みの中の位置しか表示できない）
* 語のレベルで一致するものはダジャレとして不適格なので排除する（'とても高いタケノコ'と'寄席の流行りタケノコ'とはダジャレ的類似性を持たない）
* MeCabに未知語の読みを返すようにさせる(--unk-featureオプションを与える)
* 母音による判定以外の類似度判定の実装．具体的には，拗音・促音・長音の対応（「千代子のチョコ」「暴徒がぼうっとする」「暴徒がボートに乗る」）
  * cf. [kurehajime/dajarep: ダジャレを検索するコマンド](https://github.com/kurehajime/dajarep)

