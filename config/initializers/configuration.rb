Workarea.configure do |config|
  # Add checkout content area for gift wrapping
  config.content_areas['checkout'] ||= []
  config.content_areas['checkout'] << 'gift_wrapping'

  config.pricing_calculators.insert_after(
    'Workarea::Pricing::Calculators::CustomizationsCalculator',
    'Workarea::Pricing::Calculators::GiftWrappingCalculator'
  )

  config.seeds << 'Workarea::GiftWrappingSeeds'
end
