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

    def pickup(num = 5)
      # Qiita.tag_items('ruby').each do |item|
      #   puts item.title
      #   puts item.url
      #   puts item.stock
      # end
      Qiita.tag_items('ruby')[0..num-1]
    end
  end
end

