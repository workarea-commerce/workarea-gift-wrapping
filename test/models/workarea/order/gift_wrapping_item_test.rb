require 'test_helper'

module Workarea
  class Order
    class GiftWrappingItemTest < TestCase
      def test_quantity
        item = Order::Item.new(
          quantity: 1,
          gift_wrap_quantities: { 'GW01' => 1 }
        )

        item.quantity = 3
        assert_equal(3, item.quantity)
        assert_equal({ 'GW01' => 3 }, item.gift_wrap_quantities)
      end

      def test_reset_gift_wrapping
        wrap = create_gift_wrap(name: 'Test', sku: 'GW01')

        item = Order::Item.new(
          quantity: 2,
          gift_wrap_quantities: { 'GW01' => 2 },
          gift_wraps_attributes: [wrap.as_document]
        )

        item.reset_gift_wrapping
        assert_empty(item.gift_wrap_quantities)
        assert_empty(item.gift_wraps_attributes)
      end

      def test_add_gift_wrap
        wrap = create_gift_wrap(name: 'Test', sku: 'GW01')
        item = Order::Item.new(quantity: 3)

        item.add_gift_wrap(wrap.as_document, 1)

        assert_equal({ 'GW01' => 1 }, item.gift_wrap_quantities)
        assert_equal(1, item.gift_wraps_attributes.count)

        item.add_gift_wrap(wrap.as_document)

        assert_equal({ 'GW01' => 3 }, item.gift_wrap_quantities)
        assert_equal(1, item.gift_wraps_attributes.count)

        item.add_gift_wrap(wrap.as_document, 10)

        assert_equal({ 'GW01' => 3 }, item.gift_wrap_quantities)
        assert_equal(1, item.gift_wraps_attributes.count)
      end
    end
  end
end
