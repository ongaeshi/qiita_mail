# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/21

require 'qiita_mail/marshal_file'

module QiitaMail
  class Storage
    def self.default_filename
      File.expand_path('~/.qiita_mail.marshal')
    end
    
    def initialize(filename = Storage.default_filename)
      @filename = filename
      
      if File.exist?(@filename)
        @data = MarshalFile.load(@filename)
      else
        @data = {}
      end
    end

    def add_reading(uuid)
      @data[:reading] ||= {}
      @data[:reading][uuid] = true
    end

    def reading?(uuid)
      if @data.has_key? :reading
        @data[:reading].has_key? uuid
      else
        false
      end
    end

    def save
      MarshalFile.save(@filename, @data)
    end
  end
end

