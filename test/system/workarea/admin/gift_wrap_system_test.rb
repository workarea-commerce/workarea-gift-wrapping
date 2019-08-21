require 'test_helper'

module Workarea
  module Admin
    class GiftWrapSystemTest < Workarea::SystemTest
      include Admin::IntegrationTest

      def test_managing_gift_wraps
        visit admin.catalog_gift_wraps_path

        click_link t('workarea.admin.catalog_gift_wraps.index.button')

        fill_in 'gift_wrap[name]', with: 'Test'
        fill_in 'gift_wrap[sku]', with: 'GIFT_WRAP'
        fill_in 'pricing_sku[regular]', with: '2.50'
        click_button t('workarea.admin.catalog_gift_wraps.new.button')

        assert(page.has_content?('Success'))
        assert(page.has_content?('Test'))
        assert(page.has_content?('GIFT_WRAP'))

        click_link 'Test'

        click_link t('workarea.admin.catalog_gift_wraps.edit.view_pricing')
        assert_current_path(admin.pricing_sku_path('GIFT_WRAP'))
        assert(page.has_content?('2.50'))

        visit admin.catalog_gift_wraps_path
        click_link 'Test'

        fill_in 'gift_wrap[name]', with: 'Fancy'
        click_button t('workarea.admin.catalog_gift_wraps.edit.button')

        assert(page.has_content?('Success'))
        assert(page.has_no_content?('Test'))
        assert(page.has_content?('Fancy'))
        assert(page.has_content?('GIFT_WRAP'))

        click_link 'Fancy'
        click_link t('workarea.admin.actions.delete')

        assert(page.has_content?('Success'))
        assert(page.has_no_content?('Fancy'))
        assert(page.has_no_content?('GIFT_WRAP'))
      end
    end
  end
end
