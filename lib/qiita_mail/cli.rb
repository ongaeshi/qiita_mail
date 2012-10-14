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
# require 'qiita_mail/format_text'
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
      mail_body = pickup_and_format
      
      # メールの送信
      puts "Send mail ..."
      mailer = Mailer.new('tuto0621@gmail.com', mail_body)
      mailer.deliver
    end

    desc "file", "Write file."
    def file(filename)
      # ピックアップ
      mail_body = pickup_and_format
      
      # ファイルに書き込み
      puts "Write file -> #{filename}"
      open(filename, "w") do |f|
        f.write mail_body
      end
    end

    private

    def pickup_and_format
      # 記事をピックアップ
      puts "Pickup from Qiita.com ..."
      selector = Selector.new("")
      pickup_items = selector.pickup(5)

      # テキスト整形
      FormatHTML.new(pickup_items).to_s
    end
  end
end
