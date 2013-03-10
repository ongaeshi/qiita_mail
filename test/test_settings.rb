# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/21

require 'qiita_mail/settings'
require 'test_helper'

module QiitaMail
  class TestSettings < Test::Unit::TestCase
    include FileTestUtils
    
    def test_default_filename
      assert_match /\.qiita_mail.yaml/, Settings.default_filename
    end

    def test_empty
      obj = Settings.new('.qiita_mail.yaml') # データが無い場合は新規作成
      assert_equal "", obj.email
      assert_equal "", obj.email_from
      assert_equal [], obj.keywords
      assert_equal true, obj.empty?
      obj.save
    end

    def test_exist_yaml
      obj = Settings.new(tmp_path('../data/qiita_mail.yaml'))
      assert_equal "qiita_mail@example.com", obj.email
      assert_equal "qiita_mail@example.com", obj.email_from
      assert_equal ['ruby', 'javascript'], obj.keywords
      assert_equal false, obj.empty?
    end

    def test_exist_yaml_from
      obj = Settings.new(tmp_path('../data/qiita_mail_from.yaml'))
      assert_equal "qiita_mail@example.com", obj.email
      assert_equal "qiita_mail_from@example.com", obj.email_from
    end

    def teardown
      teardown_custom(true)
    end
  end
end
