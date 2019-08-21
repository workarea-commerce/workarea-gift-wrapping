require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::GiftWrapping::Engine.root
  Workarea::Teaspoon.apply(config)
end
