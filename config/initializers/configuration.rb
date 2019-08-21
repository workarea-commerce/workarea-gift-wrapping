Workarea.configure do |config|
  # Maximum length allowed for order gift messages
  config.gift_message_max_length = 500

  # Add checkout content area for gift wrapping
  config.content_areas['checkout'] ||= []
  config.content_areas['checkout'] << 'gift_wrapping'

  config.pricing_calculators.insert_after(
    'Workarea::Pricing::Calculators::CustomizationsCalculator',
    'Workarea::Pricing::Calculators::GiftWrappingCalculator'
  )

  config.seeds << 'Workarea::GiftWrappingSeeds'
end
