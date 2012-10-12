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
    desc "red WORD", "red words print."
    def red(word)
      say(word, :red)
    end
  end
end
