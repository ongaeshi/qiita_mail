# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/12

require 'rubygems'
require 'thor'
require 'qiita_mail/cli_core'

module QiitaMail
  class CLI < Thor
    desc "init", "Init setting."
    def init
      CliCore.new.init
    end

    desc "deliver", "Deliver mail."
    def deliver
      CliCore.new.deliver
    end

    desc "html [filename]", "Write html."
    def html(filename = nil)
      CliCore.new.file(:html, filename)
    end

    desc "text [filename]", "Write text format."
    def text(filename = nil)
      CliCore.new.file(:text, filename)
    end
  end
end
