# -*- coding: utf-8 -*-
# http://qiita.com/k-shogo/items/64d554322d308745fed9
# ローマ字変換
# https://gist.github.com/kimoto/1940479

require './jasound.rb'

class StringWithVowels 
  attr_accessor :string
  attr_reader :vowels, :vowels_list

  def vowels
    unless (@vowels) then
      sound_list = JaSound.split(@string)
      @vowels = sound_list.map{|s| JaSound.to_vowel_with_help(s)}.join('')
    end
    return @vowels
  end

  def vowels_list
    unless (@vowels_list) then
      @vowels_list = []
    end
    return @vowels_list
  end


  # りゅうきゅうでゆうきゅう
  # は，母音になおすと
  # ウウウウエウウウウ
  # なので，たとえば母音[0, 4], 母音[5, 4]がダジャレになっている
  # しかし，これはもとの文字列では，
  # もと[0,6], もと[7, 5]にあたる
  # この状況で，もと，5, 4を与えられたとき，「ゆうきゅう」を返したい
  def find_at_vowels_position(vowels_where, vowels_length)
    genuine_where = self.at_vowels_where_in(vowels_where)
    genuine_length = self.at_vowels_where_in(vowels_where + vowels_length) - genuine_where
    return @string[genuine_where, genuine_length]
  end

  @private

  def at_vowels_where_in(vowels_where)
    start = -1
    for slice_length in 0..(@string.size)  do
      
      former_yomi = @string[0, slice_length]
      former_sound_list = JaSound.split(former_yomi)
      former_vowels = former_sound_list.map{|s| JaSound.to_vowel_with_help(s)}.join('')
      self.vowels_list[slice_length] = former_vowels
      self.vowels_list[former_vowels.size] = former_vowels
      # TODO うまくキャッシュしたいが
      

      # 「ゆうきゅう」の直前の「りゅうきゅうで」は母音にすると5文字
      # したがってその次の位置がスタート地点
      if (former_vowels.size == vowels_where) then
        start = slice_length
      elsif (start >= 0)  then
        # 条件を満たすかぎりslice_lengthを増やして，満たさなくなったところで脱出
        # これにより，「りゅうき」と「りゅうきゅ」とで母音数は同じでも後者をとるようにできる
        break
      end
    end

    return start
  end

end


