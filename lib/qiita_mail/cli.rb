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
require 'mail'

module QiitaMail
  class CLI < Thor
    desc "init", "Init setting."
    def init
      p 'Init setting'
    end

    desc "deliver", "Deliver mail."
    def deliver(token)
      puts "Pickup from Qiita.com ..."

      # 記事をピックアップ
      selector = Selector.new(token)
      pickup_items = selector.pickup(5)

      # 送信するテキスト
      mail_body =  FormatText.new(pickup_items).to_s

      puts "Send mail ..."

      mail = Mail.new do
        to      'ongaeshi0621@gmail.com'
        subject 'Qiita Mail'
        body    mail_body
      end

      mail.charset = 'utf-8'
      mail.delivery_method :sendmail
      mail.deliver
    end
  end
end
