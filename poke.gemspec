Gem::Specification.new do |s|
  s.name         = 'pokes'
  s.version      = '0.0.1'
  s.summary      = 'e2e tests, API-first'
  s.description  = 'FP browser automation, pessimistic testing, HAML proxies'
  s.authors      = ['Luka Licina']
  s.email        = ['licina.luka@outlook.com']
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/gnzoss/poke'
  s.files        = Dir.glob('{lib,bin}/**/*')
  s.require_path = 'lib'
  s.executables << 'poke'
end
