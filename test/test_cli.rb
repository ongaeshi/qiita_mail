# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/15

require 'qiita_mail/cli.rb'
require 'test_helper'

module QiitaMail
  class TestCLI < Test::Unit::TestCase
    def setup
      $stdout = StringIO.new
      @orig_stdout = $stdout
    end

    def teardown
      $stdout = @orig_stdout
    end

    def test_no_arg
      assert_match /Tasks:/, command("")
    end

    private

    def command(arg)
      CLI.start(arg.split)
      $stdout.string
    end
  end
end
