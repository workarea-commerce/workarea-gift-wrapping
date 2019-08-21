module Workarea
  module Pricing
    module Calculators
      class GiftWrappingCalculator
        include Calculator

        def adjust
          order.items.each do |item|
            next unless item.gift_wrap_quantities.present?

            item.gift_wrap_quantities
                .each { |sku, quantity| adjust_for_wrap(item, sku, quantity) }
          end
        end

        def adjust_for_wrap(item, wrap_sku, quantity)
          price = pricing.for_sku(wrap_sku, quantity: quantity)

          total = price.sell * quantity
          return unless total > 0

          item.adjust_pricing(
            price: 'item',
            quantity: quantity,
            description: I18n.t('workarea.gift_wrap.price_adjustment'),
            calculator: self.class.name,
            amount: total,
            data: {
              'on_sale' => price.on_sale?,
              'original_price' => price.regular.to_f,
              'tax_code' => price.tax_code
            }
          )
        end
      end
    end
  end
end
