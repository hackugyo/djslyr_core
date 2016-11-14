# -*- coding: utf-8 -*-

require 'natto'

class JaKana
  def self.to_kanas(s1, delimiter = '')
    elements = []
    Natto::MeCab.new.parse(s1) do |node|
      element = node.feature.split(',')[7] # じつは -> ジツハ, 表現 -> ヒョウゲン
      # element = node.feature.split(',')[8] # じつは -> ジツワ, 表現 -> ヒョーゲン
      elements << element unless (element == '*' || node.feature.split(',')[0] == '記号')
    end
    return elements.join(delimiter)
  end

end
