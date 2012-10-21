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

module QiitaMail
  class CLI < Thor
    desc "init", "Init setting."
    def init
      puts "Create 'qiita_mail.yml'"
    end

    desc "deliver", "Deliver mail."
    def deliver
      # ピックアップ
      puts "Pickup from Qiita.com ..."
      mail_body = pickup_and_format(:html)
      
      # メールの送信
      puts "Send mail ..."
      mailer = Mailer.new('tuto0621@gmail.com', mail_body)
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
      # 記事をピックアップ
      selector = Selector.new("")
      pickup_items = selector.pickup(5)

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
