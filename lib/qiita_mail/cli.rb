# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/12

require 'qiita_mail'
require 'thor'
require 'qiita_mail/selector'

module QiitaMail
  class CLI < Thor
    desc "init", "Init setting."
    def init
      p 'Init setting'
    end

    desc "deliver", "Deliver mail."
    def deliver(token)
      selector = Selector.new(token)
      selector.pickup
    end
  end
end
