# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/13

require 'rubygems'
require 'mail'

module QiitaMail
  class Mailer
    def initialize(from, to, body)
      @mail = Mail.new do
        from    from
        to      to
        subject 'Qiita Mail'
        # body    mail_body
      end

      @mail.charset = 'utf-8'

      @mail.html_part = Mail::Part.new {
        content_type 'text/html; charset=UTF-8'
        body body
      }

      @mail.delivery_method :sendmail
    end

    def deliver
      @mail.deliver
    end
  end
end

