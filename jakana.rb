# -*- coding: utf-8 -*-

require 'MeCab'

class JaKana
  def self.to_kanas(s1, delimiter = '')
    node = MeCab::Tagger.new.parseToNode(s1)
    elements = []
    while node
      element = node.feature.split(',')[7] # じつは -> ジツハ, 表現 -> ヒョウゲン
      # element = node.feature.split(',')[8] # じつは -> ジツワ, 表現 -> ヒョーゲン
      elements << element unless (element == '*' || node.feature.split(',')[0] == '記号')
      node = node.next
    end
    return elements.join(delimiter)
  end

end
