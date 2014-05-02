# -*- coding: utf-8 -*-

class JaSound
  LARGE_MAP = {
    %w|ア カ サ タ ナ ハ マ ヤ ラ ワ ガ ザ ダ バ パ| => 'ア',
    %w|イ キ シ チ ニ ヒ ミ    リ ヰ ギ ジ ヂ ビ ピ| => 'イ',
    %w|ウ ク ス ツ ヌ フ ム ユ ル ヴ グ ズ ヅ ブ プ| => 'ウ',
    %w|エ ケ セ テ ネ ヘ メ    レ ヱ ゲ ゼ デ ベ ペ| => 'エ',
    %w|オ コ ソ ト ノ ホ モ ヨ ロ ヲ ゴ ゾ ド ボ ポ| => 'オ'
  }
  SMALL_MAP = {
    %w|ァ ャ ヮ| => 'ア',
    %w|ィ      | => 'イ',
    %w|ゥ ュ   | => 'ウ',
    %w|ェ      | => 'エ',
    %w|ォ ョ   | => 'オ'
  }
  LARGE_STR = LARGE_MAP.keys.flatten.join('')
  SMALL_STR = SMALL_MAP.keys.flatten.join('')
  HELP_STR = %w|ッ ー ン|.join('')

  def self.split(text)
    text.scan /[#{LARGE_STR}][#{SMALL_STR}#{HELP_STR}]*/u
  end

  def self.only_kana?(text)
    text.match /^[#{LARGE_STR}#{SMALL_STR}#{HELP_STR}]+$/u
  end

  def self.to_vowel(sound)
    result = to_vowel_with_help(sound)
    result.gsub(/[#{HELP_STR}]/u, '')
  end

  def self.to_vowel_with_help(sound)
    regexp = /([#{LARGE_STR}])([#{SMALL_STR}]?)/u
    sound.sub(regexp) do
      map = $2 == '' ? LARGE_MAP : SMALL_MAP
      snd = $2 == '' ? $1 : $2
      map.each {|l, c| break c if l.include?(snd) }
    end
  end
end
