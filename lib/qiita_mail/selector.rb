# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/13

require 'rubygems'
require 'qiita_mail/marshal_file'
require 'qiita_mail/qiita_custom'

module QiitaMail
  CACHE_FILE = File.join(File.dirname(__FILE__), '../../test/data/pickup_cache.marshal')

  class Selector
    # -----------------------
    # パラメータ

    TOP_BONUS = 30
    PER_PAGE  = 40

    # デバッグ用
    USE_CACHE = false # デバッグ用のキャッシュからデータをロードする(高速)
    
    # -----------------------

    def initialize(settings, storage)
      @settings = settings
      @storage  = storage
    end

    def pickup(num = 5)
      # 候補記事をピックアップ
      container = pickup_in

      puts "Calculate Score .."

      # 既読記事は除外
      container.each_with_index do |items, index|
        container[index].delete_if do |item|
          @storage.reading? item.uuid
        end
      end

      # ScoredItemに変換、スコア順にソート
      container = container.map {|items| items.map {|item| ScoredItem.new item}.sort.reverse }

      # ボーナス加算
      container.each do |items|
        items[0].add_score(TOP_BONUS) unless items.empty?
      end

      # 合算して、重複は削除、スコア順にソート
      results = container.reduce([]) {|r,i| r += i}.uniq{|i| i.item.uuid}.sort.reverse

      # スコアの高い物をピックアップ、Itemに戻して返す
      results[0..num-1].map {|scored_item| scored_item.item}
    end

    private

    class ScoredItem
      attr_reader :item
      attr_reader :score
      
      def initialize(item)
        @item  = item
        @score = item.stock_count * 10 + item.comment_count * 20
      end

      def add_score(v)
        @score += v
      end

      def <=>(rhs)
        self.score <=> rhs.score
      end
    end

    def print_container(container)
      container.each_with_index do |items, index|
        puts "-- #{@settings.keywords[index]} --"
        print_items(items)
      end
    end

    def print_items(items)
      items.each do |item|
        if item.class == ScoredItem
          puts format("%3d: %s", item.score, item.item.title)
        else
          p [item.uuid, item.title]
        end
      end
    end

    def pickup_in
      unless USE_CACHE
        items = pickup_items
        # MarshalFile.save(CACHE_FILE, items) # @debug キャッシュを保存
        items
      else
        items = MarshalFile.load(CACHE_FILE)
      end
    end

    def pickup_items
      items = []

      # 最新記事から取得
      items << Qiita.items({:per_page => PER_PAGE})

      # 登録したキーワードから取得
      @settings.keywords.each do |tag|
        # items << Qiita.tag_items(tag)
        items << Qiita.search_items(tag, {:per_page => PER_PAGE})
      end

      items
    end
    
  end
end

