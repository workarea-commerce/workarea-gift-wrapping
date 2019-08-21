module Workarea
  module Factories
    module GiftWrapping
      Factories.add(self)

      def create_gift_wrap(overrides = {})
        attributes =
          { name: 'Test', sku: 'GW_TEST' }.merge(overrides.slice(:name, :sku))

        Workarea::Catalog::GiftWrap.create!(attributes).tap do |wrap|
          if overrides[:pricing].present?
            attributes = { id: wrap.sku, prices: [{ regular: 1.to_m }] }
                         .merge(overrides[:pricing])

            create_pricing_sku(attributes)
          end
        end
      end
    end
  end
end
