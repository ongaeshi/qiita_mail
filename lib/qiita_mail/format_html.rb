# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/10/13

require 'rubygems'
require 'qiita'
require 'pp'

module QiitaMail
  class FormatHTML
    def initialize(items)
      @items = items
    end

    HEADER = <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title>Qiita Mail</title>
</head>
<body style="color:#000000; font-size:14px;">
<div id="banner" style="font-size: 36px; color:#FFFFFF; background-color:#5ABB0E">QiitaMail</div>
<p>こんにちは！</p>
<p><a href="http://qiita.com">Qiita</a>で今話題になっている記事をお届けします。</p>
EOF

    FOOTER = <<EOF
</body>
</html>
EOF
   
    def to_s
      HEADER + @items.map {|item|
        <<EOF
<hr>
<div id="title" style="font-size: 28px;"><img src="#{item.user.profile_image_url}" style="margin-right: 5px; width: 72px;"/><a href="#{item.url}" style="color:#2C6EBD; text-decoration:none;">#{item.title}</a></div>
<div id="summary">#{item.body[0..200]}</div>
<div id="footer">ストック(#{item.stock_count}) コメント(#{item.comment_count}) #{item.created_at_in_words}</div>
EOF
      }.join("\n") + FOOTER
    end
  end
end
