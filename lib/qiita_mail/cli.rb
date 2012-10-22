# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/12

require 'rubygems'
require 'thor'
require 'qiita_mail/cli_core'

module QiitaMail
  class CLI < Thor
    desc "init", "Init setting."
    def init
      CliCore.new.init
    end

    desc "deliver", "Deliver mail."
    def deliver
      CliCore.new.deliver
    end

    desc "html [filename]", "Write html."
    def html(filename = nil)
      CliCore.new.file(:html, filename)
    end

    desc "text [filename]", "Write text format."
    def text(filename = nil)
      CliCore.new.file(:text, filename)
    end

    private

    def pickup_and_format(kind)
      # ストレージを作成
      storage = Storage.new
      
      # 記事をピックアップ
      selector = Selector.new("", storage)
      pickup_items = selector.pickup(5)

      # ピックアップした記事をストレージに記録
      pickup_items.each do |item|
        storage.add_reading(item.uuid)
      end
      storage.save
      
      # テキスト整形
      case kind
      when :html
        FormatHTML.new(pickup_items).to_s
      when :text
        FormatText.new(pickup_items).to_s
      end
    end

    def write_or_puts(filename, str)
      if (filename)
        open(filename, "w") do |f|
          f.write str
        end
      else
        puts str
      end
    end
  end
end
