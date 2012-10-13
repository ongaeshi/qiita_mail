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
  <style type="text/css">
    body, td { color:#000000; font-size:14px; }
    #banner  { font-size: 36px; color:#FFFFFF; background-color:#5ABB0E }
    #title   { font-size: 28px; }
    #title a { color:#2C6EBD; text-decoration:none; }
  </style>
</head>
<body>
<div id="banner">QiitaMail</div>
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
<div id="title"><a href="#{item.url}">#{item.title}</a></div>
<div id="summary">#{item.body[0..200]}</div>
<div id="footer">ストック(#{item.stock_count}) コメント(#{item.comment_count}) #{item.created_at_in_words}</div>
EOF
      }.join("\n") + FOOTER
    end
  end
end
