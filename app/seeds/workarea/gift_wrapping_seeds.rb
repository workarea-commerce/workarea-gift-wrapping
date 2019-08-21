module Workarea
  class GiftWrappingSeeds
    def perform
      puts 'Adding gift wrapping options...'

      Workarea::Pricing::Sku.create!(
        id: 'GIFT_WRAP_1',
        prices: [{ regular: 1.to_m }]
      )
      Workarea::Catalog::GiftWrap.create!(name: 'Basic', sku: 'GIFT_WRAP_1')

      Workarea::Pricing::Sku.create!(
        id: 'GIFT_WRAP_2',
        prices: [{ regular: 2.to_m }]
      )
      Workarea::Catalog::GiftWrap.create!(name: 'Fancy', sku: 'GIFT_WRAP_2')
    end
  end
end
