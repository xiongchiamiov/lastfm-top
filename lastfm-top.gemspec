# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'lastfm-top'
  s.version = '0.1.0'
  s.date = Time.now.strftime('%Y-%m-%d')

  s.authors = ["xiongchiamiov"]
  s.email = ['xiong.chiamiov@gmail.com']
  
  s.add_dependency 'json'
  s.add_dependency 'englify'
  
  s.files = %w( COPYING Rakefile README.md )
  s.files += Dir.glob "bin/*"
  
  s.executables = 'lastfm-top'
  s.extra_rdoc_files = ['README.md']
  
  s.summary = %q{View frequently-queried information from a Last.fm profile.}
  s.homepage = 'https://github.com/xiongchiamiov/lastfm-top/'
  s.description = %q{A small script to view top artists, albums and tracks of a Last.fm user.}
end
