# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/12

require 'qiita_mail'
require 'thor'

module QiitaMail
  class CLI < Thor
    desc "init", "Init setting."
    def init
      p 'Init setting'
    end

    desc "deliver", "Deliver mail."
    def deliver
      p 'deliver!!'
    end
  end
end
