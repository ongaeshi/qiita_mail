# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/22

require 'yaml'

module QiitaMail
  class Settings
    def self.default_filename
      File.expand_path('~/.qiita_mail.yaml')
    end
    
    def initialize(filename = Settings.default_filename)
      @filename = filename
      
      if File.exist?(@filename)
        open(@filename) do |f|
          @data = YAML.load(f.read)
        end
      else
        @data = {
          'email' => '',
          'keywords' => []
        }
        @is_empty = true
      end
    end

    def save
      open(@filename, "w") do |f|
        f.write YAML.dump(@data)
      end
    end

    def email
      @data['email']
    end

    def keywords
      @data['keywords']
    end

    def empty?
      !@is_empty.nil?
    end
  end
end


