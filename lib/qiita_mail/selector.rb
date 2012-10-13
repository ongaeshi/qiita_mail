# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/13

require 'rubygems'
require 'qiita'

module QiitaMail
  class Selector
    def initialize(token)
      @token = token
    end

    TAGS = ['ruby', 'javascript']

    def pickup(num = 5)
      items = []

      TAGS.each do |tag|
          items += Qiita.tag_items(tag)
      end

      items = items.sort { |a, b|
        a.stock_count <=> b.stock_count
      }.reverse

      items[0..num-1]
    end
  end
end

