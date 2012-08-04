# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'capistrano-deploy-management'
  s.version     = '0.1.3'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Dominik Rodler']
  s.email       = ['dominik.rodler@gmail.com']
  s.homepage    = 'https://github.com/drdla/capistrano-deploy-management'
  s.summary     = 'Capistrano deploy recipes; forked from https://github.com/lest/capistrano-deploy'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_dependency('capistrano', '~> 2.9')
end