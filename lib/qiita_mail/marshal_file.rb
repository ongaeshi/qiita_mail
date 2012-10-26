# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/21

require 'rubygems'
require 'hashie'

module QiitaMail
  module MarshalFile
    module_function

    def save(filename, obj)
      # puts "MarshalFile#save -> #{filename}"
      open(filename, "w") do |f|
        f.write Marshal.dump(obj)
      end
    end

    def load(filename)
      # puts "MarshalFile#load <- #{filename}"
      open(filename) do |f|
        Marshal.load(f.read)
      end
    end
  end
end

