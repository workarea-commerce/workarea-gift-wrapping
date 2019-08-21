require 'test_helper'

module Workarea
  module Pricing
    module Calculators
      class GiftWrappingCalculatorTest < TestCase
        setup :setup_gift_wraps

        def setup_gift_wraps
          create_gift_wrap(name: 'Standard', sku: 'GW1', pricing: { tax_code: '001', prices: [{ regular: 2.to_m }] })
          create_gift_wrap(name: 'Special', sku: 'GW2', pricing: { tax_code: '002', prices: [{ regular: 1.to_m }] })
        end

        def test_adjust
          order = Order.new
          order.add_item(product_id: 'PRODUCT', sku: 'SKU1', quantity: 2, gift_wrap_quantities: { 'GW1' => 2 })
          order.add_item(product_id: 'PRODUCT', sku: 'SKU2', quantity: 1, gift_wrap_quantities: { 'GW2' => 1 })

          GiftWrappingCalculator.test_adjust(order)

          assert_equal(1, order.items.first.price_adjustments.length)
          assert_equal('item', order.items.first.price_adjustments.first.price)
          assert_equal(4.to_m, order.items.first.price_adjustments.first.amount)
          assert_equal('001', order.items.first.price_adjustments.first.data['tax_code'])
          assert_equal(
            I18n.t('workarea.gift_wrap.price_adjustment'),
            order.items.first.price_adjustments.first.description
          )

          assert_equal(1, order.items.second.price_adjustments.length)
          assert_equal('item', order.items.second.price_adjustments.first.price)
          assert_equal(1.to_m, order.items.second.price_adjustments.first.amount)
          assert_equal('002', order.items.second.price_adjustments.first.data['tax_code'])
          assert_equal(
            I18n.t('workarea.gift_wrap.price_adjustment'),
            order.items.second.price_adjustments.first.description
          )
        end

        # Note: Orders like this are not possible in the UI, but gift wrapping
        # is modeled in such a way that it can be done if the interface to build
        # it was added as a customization.
        def test_adjust_with_partial_and_mixed_wrappings
          order = Order.new
          order.add_item(product_id: 'PRODUCT', sku: 'SKU1', quantity: 3, gift_wrap_quantities: { 'GW1' => 1, 'GW2' => 2 })
          order.add_item(product_id: 'PRODUCT', sku: 'SKU2', quantity: 2, gift_wrap_quantities: { 'GW2' => 1 })

          GiftWrappingCalculator.test_adjust(order)

          assert_equal(2, order.items.first.price_adjustments.length)

          assert_equal('item', order.items.first.price_adjustments.first.price)
          assert_equal(1, order.items.first.price_adjustments.first.quantity)
          assert_equal(2.to_m, order.items.first.price_adjustments.first.amount)
          assert_equal('001', order.items.first.price_adjustments.first.data['tax_code'])
          assert_equal(
            I18n.t('workarea.gift_wrap.price_adjustment'),
            order.items.first.price_adjustments.first.description
          )

          assert_equal('item', order.items.first.price_adjustments.second.price)
          assert_equal(2.to_m, order.items.first.price_adjustments.second.amount)
          assert_equal(2, order.items.first.price_adjustments.second.quantity)
          assert_equal('002', order.items.first.price_adjustments.second.data['tax_code'])
          assert_equal(
            I18n.t('workarea.gift_wrap.price_adjustment'),
            order.items.first.price_adjustments.first.description
          )

          assert_equal(1, order.items.second.price_adjustments.length)

          assert_equal('item', order.items.second.price_adjustments.first.price)
          assert_equal(1.to_m, order.items.second.price_adjustments.first.amount)
          assert_equal(1, order.items.second.price_adjustments.first.quantity)
          assert_equal('002', order.items.second.price_adjustments.first.data['tax_code'])
          assert_equal(
            I18n.t('workarea.gift_wrap.price_adjustment'),
            order.items.second.price_adjustments.first.description
          )
        end
      end
    end
  end
end
