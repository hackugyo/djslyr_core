#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# http://qiita.com/k-shogo/items/64d554322d308745fed9
# ローマ字変換
# https://gist.github.com/kimoto/1940479

# Usage: ruby djslyr.rb text
# Example: ruby djslyr.rb '琉球で有給'

require './jakana.rb'
require './dajare.rb'
require 'optparse'
require 'pp'

def main(args)
  opts, args = parse_args(args)
  
  enumerable = [args[0]]
  if (opts[:file_path]) then
    enumerable = File.open(opts[:file_path]).lines
  end
   
  enumerable.each do |s1|

    next unless s1 && s1.length > 0

    puns =  Dajare.find_puns(s1)
    puns.sort!
    next unless puns.length > 0 && puns[0]

    puts "\n" + s1 
    puts JaKana.to_kanas(s1, ' ')
    puts "#{puns.size}カ所の母音一致を発見しました．最長#{puns[0].length}連続"

    for position in 0..(puns.size - 1) do
      pun = puns[position]
      # TODO 未実装 next unless (pun.is_legitimate)
      first = pun.original_kana_former
      second  = pun.original_kana_later
      puts "  {#{first}(#{pun.former_place}文字め付近), #{second}(#{pun.later_place}文字め付近)} (#{pun.vowels})"
      break unless opts[:verbose]
    end
  end
end

def parse_args(args)
  opts = {}
  OptionParser.new do |opt|
    opt.on('--verbose', 'Show all dajares') {|v| opts[:verbose] = true }
    opt.on('-i PATH', 'input file path') {|v| opts[:file_path] =  v }
    opt.parse!(args)
  end
  [opts, args]
end

main(ARGV)








