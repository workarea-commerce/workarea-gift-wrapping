require 'test_helper'

module Workarea
  module Storefront
    class GiftWrapSystemTest < Workarea::SystemTest
      include Storefront::SystemTest

      setup :setup_checkout_specs, :setup_gift_wrap, :start_guest_checkout

      def setup_gift_wrap
        create_gift_wrap(name: 'Standard', sku: 'GW1', pricing: { tax_code: '001', prices: [{ regular: 1.to_m }] })
        create_gift_wrap(name: 'Special', sku: 'GW2', pricing: { tax_code: '001', prices: [{ regular: 1.5.to_m }] })
      end

      def test_successfully_checking_out
        assert_current_path(storefront.checkout_addresses_path)
        fill_in_email
        fill_in_shipping_address
        uncheck 'same_as_shipping'
        fill_in_billing_address
        click_button t('workarea.storefront.checkouts.continue_to_shipping')

        assert_current_path(storefront.checkout_shipping_path)
        assert(page.has_content?('Success'))

        fill_in 'gift_message', with: 'test gift message is here'

        item = Order.last.items.first
        select 'Special', from: "gift_wrapping[#{item.id}][gift_wrap]"

        click_button t('workarea.storefront.checkouts.continue_to_payment')

        assert_current_path(storefront.checkout_payment_path)
        assert(page.has_content?('Success'))

        assert(page.has_content?(t('workarea.storefront.checkouts.gift_message')))
        assert(page.has_content?('test gift message is here'))
        assert(page.has_content?('Special'))
        assert(page.has_content?(t('workarea.gift_wrap.price_adjustment')))
        assert(page.has_content?('$1.50')) # gift wrapping

        assert(page.has_content?('22 S. 3rd St.'))
        assert(page.has_content?('Philadelphia'))
        assert(page.has_content?('PA'))
        assert(page.has_content?('19106'))
        assert(page.has_content?('Ground'))

        assert(page.has_content?('Integration Product'))
        assert(page.has_content?('SKU'))

        assert(page.has_content?('$6.50')) # Subtotal
        assert(page.has_content?('$7.00')) # Shipping
        assert(page.has_content?('$0.94')) # Tax
        assert(page.has_content?('$14.44')) # Total

        fill_in_credit_card
        click_button t('workarea.storefront.checkouts.place_order')

        assert_current_path(storefront.checkout_confirmation_path)

        assert(page.has_content?('Success'))
        assert(page.has_content?(t('workarea.storefront.flash_messages.order_placed')))
        assert(page.has_content?(Order.first.id))

        assert(page.has_content?('22 S. 3rd St.'))
        assert(page.has_content?('Philadelphia'))
        assert(page.has_content?('PA'))
        assert(page.has_content?('19106'))
        assert(page.has_content?('Ground'))

        assert(page.has_content?('1019 S. 47th St.'))
        assert(page.has_content?('Philadelphia'))
        assert(page.has_content?('PA'))
        assert(page.has_content?('19143'))

        assert(page.has_content?('Test Card'))
        assert(page.has_content?('XX-1'))

        assert(page.has_content?('Integration Product'))
        assert(page.has_content?('SKU'))

        assert(page.has_content?(t('workarea.storefront.checkouts.gift_message')))
        assert(page.has_content?('test gift message is here'))
        assert(page.has_content?('Special'))

        assert(page.has_content?('$6.50')) # Subtotal
        assert(page.has_content?('$7.00')) # Shipping
        assert(page.has_content?('$0.94')) # Tax
        assert(page.has_content?('$14.44')) # Total
      end
    end
  end
end
