# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/12

require 'rubygems'
require 'qiita_mail'
require 'thor'
require 'qiita_mail/selector'
require 'qiita_mail/format_text'
require 'qiita_mail/format_html'
require 'qiita_mail/mailer'
require 'qiita_mail/storage'
require 'qiita_mail/settings'

module QiitaMail
  class CLI < Thor
    desc "init", "Init setting."
    def init
      settings = Settings.new

      if (settings.empty?)
        settings.save
        puts "Create -> #{Settings.default_filename}"
        puts "Please edit YAML settings!"
      else
        puts "Already exists '#{Settings.default_filename}'."
        puts "Please edit YAML settings!"
      end
    end

    desc "deliver", "Deliver mail."
    def deliver
      # ピックアップ
      puts "Pickup from Qiita.com ..."
      mail_body = pickup_and_format(:html)
      
      # メールの送信
      puts "Send mail ..."
      mailer = Mailer.new('xxxx@xxxx.com', mail_body)
      mailer.deliver
    end

    desc "html [filename]", "Write html."
    def html(filename = nil)
      # ピックアップ
      puts "Pickup from Qiita.com ..."
      mail_body = pickup_and_format(:html)
      
      # ファイルに書き込み
      puts "Write html -> #{filename}"
      write_or_puts(filename, mail_body)
    end

    desc "text [filename]", "Write text format."
    def text(filename = nil)
      # ピックアップ
      puts "Pickup from Qiita.com ..."
      mail_body = pickup_and_format(:text)
      
      # 標準出力に出力
      puts "Write text -> #{filename}"
      write_or_puts(filename, mail_body)
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
