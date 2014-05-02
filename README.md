djslyr_core
===========

ダジャレ殺すべし

Finding Dajares (puns) in your input text.

Install
--------

Require MeCab and Mecab-ruby.

http://attonblog.blogspot.jp/2013/05/mecab-ruby.html

```
$ wget https://mecab.googlecode.com/files/mecab-ruby-0.996.tar.gz
$ tar xzf mecab-ruby-0.996.tar.gz
$ cd mecab-ruby-0.996
```

Edit extconf.rb.
```
dir_config('mecab',
`mecab-config --inc-dir`.strip,
`mecab-config --libs-only-L`.strip)
```

```
$ gem build mecab-ruby.gemspec
$ gem install mecab-ruby-0.99.gem
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
