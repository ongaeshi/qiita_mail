# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "qiita_mail/version"

Gem::Specification.new do |s|
  s.name        = "qiita_mail"
  s.version     = QiitaMail::VERSION
  s.authors     = ["ongaeshi"]
  s.email       = ["ongaeshi0621@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Write a gem summary}
  s.description = %q{Write a gem description}

  s.rubyforge_project = "qiita_mail"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'thor'
  s.add_dependency 'qiita'
end
