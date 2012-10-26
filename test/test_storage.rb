# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/21

require 'qiita_mail/storage.rb'
require 'test_helper'

module QiitaMail
  class TestStorage < Test::Unit::TestCase
    include FileTestUtils
    
    def test_default_filename
      assert_match /\.qiita_mail.marshal/, Storage.default_filename
    end

    def test_initialize
      # データが無い場合は新規作成
      obj = Storage.new('.qiita_mail')
      assert_equal false, obj.reading?('7f15')
      obj.add_reading('7f15')
      assert_equal true, obj.reading?('7f15')
      obj.save

      # ロード
      obj = Storage.new('.qiita_mail')
      assert_equal true, obj.reading?('7f15')
      assert_equal false, obj.reading?('7f16')
      obj.add_reading('7f16')      
      assert_equal true, obj.reading?('7f16')
      obj.save
    end

    def teardown
      teardown_custom(true)
    end
  end
end
