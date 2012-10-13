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
require 'qiita_mail/mailer'

module QiitaMail
  class CLI < Thor
    desc "init", "Init setting."
    def init
      p 'Init setting'
    end

    desc "deliver", "Deliver mail."
    def deliver(token)
      # 記事をピックアップ
      puts "Pickup from Qiita.com ..."
      selector = Selector.new(token)
      pickup_items = selector.pickup(5)

      # テキスト整形
      mail_body =  FormatText.new(pickup_items).to_s

      # メールの送信
      puts "Send mail ..."
      mailer = Mailer.new('ongaeshi0621@gmail.com', '<pre>' + mail_body + '</pre>')
      mailer.deliver
    end
  end
end
