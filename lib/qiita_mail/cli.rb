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
      p 'Init setting'
    end

    desc "deliver", "Deliver mail."
    def deliver
      # 記事をピックアップ
      puts "Pickup from Qiita.com ..."
      selector = Selector.new("")
      pickup_items = selector.pickup(5)

      # テキスト整形
      mail_body =  FormatHTML.new(pickup_items).to_s

      # puts mail_body

      # メールの送信
      puts "Send mail ..."
      mailer = Mailer.new('ongaeshi0621@gmail.com', mail_body)
      mailer.deliver
    end
  end
end
