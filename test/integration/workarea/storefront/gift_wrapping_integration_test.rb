require 'test_helper'

module Workarea
  module Storefront
    class GiftWrappingIntegrationTest < Workarea::IntegrationTest
      def test_items_that_cannot_be_gift_wrapped
        product = create_product(allow_gift_wrapping: false)
        shipping_service = create_shipping_service
        gift_wrap = create_gift_wrap

        post storefront.cart_items_path,
          params: {
            product_id: product.id,
            sku: product.skus.first,
            quantity: 1
          }

        patch storefront.checkout_addresses_path,
          params: {
            email: 'bcrouse@weblinc.com',
            billing_address: {
              first_name: 'Ben',
              last_name: 'Crouse',
              street: '12 N. 3rd St.',
              city: 'Philadelphia',
              region: 'PA',
              postal_code: '19106',
              country: 'US',
              phone_number: '2159251800'
            },
            shipping_address: {
              first_name: 'Ben',
              last_name: 'Crouse',
              street: '22 S. 3rd St.',
              city: 'Philadelphia',
              region: 'PA',
              postal_code: '19106',
              country: 'US',
              phone_number: '2159251800'
            }
          }

        get storefront.checkout_shipping_path
        assert_includes(
          response.body,
          t('workarea.storefront.checkouts.gift_wrapping_unavailable')
        )

        order = Order.first
        patch storefront.checkout_shipping_path,
          params: {
            shipping_service: shipping_service.name,
            gift_wrapping: { order.items.first.id => { gift_wrap: gift_wrap.id } }
          }

        get storefront.checkout_payment_path
        patch storefront.checkout_place_order_path,
          params: {
            payment: 'new_card',
            credit_card: {
              number: 1,
              month: 1,
              year: Time.current.year + 1,
              cvv: '999'
            }
          }

        assert_equal(1, Order.placed.count)

        refute(order.reload.items.first.allow_gift_wrapping?)
        assert(order.items.first.gift_wrap_quantities.blank?)
        assert(order.items.first.gift_wraps_attributes.blank?)
      end
    end
  end
end
