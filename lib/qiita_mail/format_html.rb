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
  class FormatHTML
    def initialize(items)
      @items = items
    end

    def to_s
      @items.map {|item|
        <<EOF
<h2><a href="#{item.url}">#{item.title}</a></h2>
ストック(#{item.stock_count}) コメント(#{item.comment_count}) #{item.created_at_in_words}
EOF
      }.join("\n")
    end
  end
end
