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
    # デバッグ用のキャッシュからデータをロードする(高速)
    USE_CACHE = 0
    
    def initialize(token, storage)
      @token = token
      @storage = storage
    end

    TAGS = ['ruby', 'javascript', 'emacs']

    def pickup(num = 5)
      # 候補記事をピックアップ
      items = pickup_in

      # 既読記事は除外
      items.delete_if do |item|
        @storage.reading? item.uuid
      end

      # ソート
      items = items.sort { |a, b|
        a.stock_count <=> b.stock_count
      }.reverse

      # 優先の高い物をピックアップ
      items[0..num-1]
    end

    private

    def pickup_in
      unless USE_CACHE
        items = pickup_items
        # キャッシュを保存
        # MarshalFile.save(CACHE_FILE, items)
      else
        items = MarshalFile.load(CACHE_FILE)
      end
    end

    def pickup_items
      items = []

      TAGS.each do |tag|
        items += Qiita.tag_items(tag)
      end

      items
    end
    
  end
end

