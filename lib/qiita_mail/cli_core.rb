# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/23

require 'qiita_mail/selector'
require 'qiita_mail/format_text'
require 'qiita_mail/format_html'
require 'qiita_mail/mailer'
require 'qiita_mail/storage'
require 'qiita_mail/settings'

module QiitaMail
  class CliCore
    def initialize
      @settings = Settings.new
      @storage  = Storage.new
    end

    def init
      if (@settings.empty?)
        @settings.save
        puts "Create -> #{Settings.default_filename}"
        puts "Please edit YAML settings!"
      else
        puts "Already exists '#{Settings.default_filename}'."
        puts "Please edit YAML settings!"
      end
    end

    def deliver
      # ピックアップ
      puts "-- #{Time.now} --"
      puts "Pickup <---- Qiita.com"
      mail_body = pickup_and_format(:html)
      
      # メールの送信
      puts "Send mail -> #{@settings.email}"
      mailer = Mailer.new(@settings.email_from, @settings.email, mail_body)
      mailer.deliver
    end

    def file(format, filename = nil)
      # ピックアップ
      puts "-- #{Time.now} --"
      puts "Pickup  <------ Qiita.com"
      mail_body = pickup_and_format(format)
      
      # ファイルに書き込み
      puts "Write '#{format.to_s}' -> #{filename}"
      write_or_puts(filename, mail_body)
    end

    private

    def pickup_and_format(kind)
      # 記事をピックアップ
      selector = Selector.new(@settings, @storage)
      pickup_items = selector.pickup(5)

      # ピックアップした記事をストレージに記録
      pickup_items.each do |item|
        @storage.add_reading(item.uuid)
      end
      @storage.save
      
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

