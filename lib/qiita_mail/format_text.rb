# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/13

require 'rubygems'
require 'qiita'
require 'pp'

module QiitaMail
  class FormatText
    def initialize(items)
      @items = items
    end

    def to_s
      @items.map {|item|
        <<EOF
Title:      #{item.title}
URL:        #{item.url}
作成時刻:   #{item.created_at_in_words}
ストック数: #{item.stock_count}
EOF
      }.join("\n")
    end
  end
end
