# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/27

require 'rubygems'
require 'qiita'

module Qiita
  class Client
    module Items
      def items(params)
        get "/items", params
      end
    end
  end
end

