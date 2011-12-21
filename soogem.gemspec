require 'rake'
Gem::Specification.new do |s|
  s.name        = 'soogem'
  s.version     = '0.0.3'
  s.date        = '2011-12-19'
  s.summary     = "A collection of classes I always seem to be rewriting"
  s.description = "A collection of classes I always seem to be rewriting"
  s.authors     = ["Jason Soo"]
  s.email       = 'wwwjscom@gmail.com'
  s.files       = FileList['lib/**/*.rb',
                      'bin/*',
                      '[A-Z]*',
                      'test/**/*'].to_a
  s.homepage    =
    'http://rubygems.org/gems/soogem'
end
