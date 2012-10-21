# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/13

require 'rubygems'
require 'qiita'
require 'qiita_mail/marshal_file'

module QiitaMail
  CACHE_FILE = File.join(File.dirname(__FILE__), '../../test/data/pickup_cache.marshal')

  class Selector
    def initialize(token)
      @token = token
    end

    TAGS = ['ruby', 'javascript']

    def pickup(num = 5)
      # 本番用ピックアップ
      items = pickup_items
      # キャッシュを保存
      # MarshalFile.save(CACHE_FILE, items)
      # キャッシュからロード(高速)
      # items = MarshalFile.load(CACHE_FILE)

      items = items.sort { |a, b|
        a.stock_count <=> b.stock_count
      }.reverse

      items[0..num-1]
    end

    private

    def pickup_items
      items = []

      TAGS.each do |tag|
        items += Qiita.tag_items(tag)
      end

      items
    end
  end
end

