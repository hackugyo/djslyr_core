# -*- coding: utf-8 -*-
require './string_with_vowels.rb'
require 'levenshtein'

# ダジャレになっている箇所を表すクラスです．
class Dajare
  attr_accessor :string_with_vowels
  attr_accessor :former_place
  attr_accessor :later_place
  attr_accessor :length
  attr_accessor :vowels

  def initialize(string, string_with_vowels, former_place, later_place, length, vowels = '')

    @string = string
    @string_with_vowels = string_with_vowels
    @former_place = former_place
    @later_place = later_place
    @length = length
    @vowels = vowels
  end

  # スペースシップ演算子
  def <=>(other)
    result = other.length - @length
    result = @former_place<=>other.former_place if result == 0
    result = @vowels<=>other.vowels if result == 0
    return result
      
  end

  def original_kana_former
    @string_with_vowels.find_at_vowels_position(@former_place, @length)
  end

  def original_kana_later
    @string_with_vowels.find_at_vowels_position(@later_place, @length)
  end

  def is_legitimate
    # あまりにも近すぎる文字列は排除。
    # TODO ただし編集距離だけだとだめな気がする．
    # {'トテモタカイタケノコ', 'ヨセノハヤリタケノコ'}は編集距離0.6だが，「タケノコ」かぶり
    # 完全一致部分は得点を大幅に割り引きたい
    # でも'下着の子の舌キノコ'のダジャレは発見したい
    # どうすればいいの
    normalized_distance = Levenshtein.normalized_distance(self.original_kana_former, self.original_kana_later)
    return normalized_distance > 0.5
  end

  # o(n^3)でダジャレを探す。
  # ダジャレ長さを長い順に最大値..3までと設定し，(2文字はダジャレと見なさない），
  # その長さの音がそれ以降に現れる箇所を調べる
  def self.find_puns(s1)
    string_with_vowels = StringWithVowels.new
    string_with_vowels.string = JaKana.to_kanas(s1, '')

    vowels = string_with_vowels.vowels
    result = []
    daja_length_max = (vowels.size) / 2
    (3..daja_length_max).to_a.reverse.each do |daja_length|
      for start in 0..(vowels.size) do

        target = vowels.slice(start, daja_length)
        after = vowels.slice((start + daja_length)..-1)
        break if (target.size > after.size)

        slice_prefix = 0

        while slice_prefix <= after.length - target.length do
          if where = after.index(target, slice_prefix) then
            dajare =  Dajare.new(s1, string_with_vowels, start , where + start + daja_length , daja_length, target)
            result << dajare 
            slice_prefix += where
          end
          slice_prefix += 1
        end # ダジャレ検索ループend
      end # ダジャレ候補位置ループend
    end # ダジャレ長さループend
    return result
  end
end
