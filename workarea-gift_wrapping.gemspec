$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'workarea/gift_wrapping/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'workarea-gift_wrapping'
  s.version     = Workarea::GiftWrapping::VERSION
  s.authors     = ['Matt Duffy']
  s.email       = ['mduffy@workarea.com']
  s.homepage    = 'https://github.com/workarea-commerce/workarea-gift-wrapping'
  s.summary     = 'Gift wrapping plugin for the Workarea Commerce Platform'
  s.description = 'Workarea Commerce Platform plugin that provides Gift message and wrapping options during checkout.'

  s.files = `git ls-files`.split("\n")

  s.license = 'Business Software License'

  s.add_dependency 'workarea', '~> 3.x', '>= 3.5.x'
end
