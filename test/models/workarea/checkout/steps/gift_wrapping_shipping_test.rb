require 'test_helper'

module Workarea
  class Checkout
    module Steps
      class GiftWrappingShippingTest < TestCase
        def test_update
          order = create_order(items: [])
          order.add_item(
            product_id: '1234',
            sku: 'SKU',
            quantity: 2,
            product_attributes: { allow_gift_wrapping: true }
          )

          checkout = Checkout.new(order)
          step = Steps::Shipping.new(checkout)

          gift_wrap = create_gift_wrap(name: 'Simple', sku: 'GW01')

          step.update(
            gift_message: 'Foo bar',
            gift_wrapping: {
              order.items.first.id.to_s => { gift_wrap: gift_wrap.id.to_s }
            }
          )

          assert_equal('Foo bar', checkout.shipping.reload.gift_message)

          item = order.reload.items.first
          assert_equal({ 'GW01' => 2 }, item.gift_wrap_quantities)
          assert_equal(gift_wrap.id, item.gift_wraps_attributes.first['_id'])
        end
      end
    end
  end
end
