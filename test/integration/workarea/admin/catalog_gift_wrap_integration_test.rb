require 'test_helper'

module Workarea
  module Admin
    class CatalogGiftWrapIntegrationTest < Workarea::IntegrationTest
      include Admin::IntegrationTest

      def test_create
        post admin.catalog_gift_wraps_path,
             params: {
               gift_wrap: { name: 'Foo', sku: 'GIFT_WRAP' },
               pricing_sku: { regular: '5.50', tax_code: '001' }
             }

        assert_redirected_to(admin.catalog_gift_wraps_path)

        gift_wrap = Catalog::GiftWrap.first
        assert_equal('Foo', gift_wrap.name)
        assert_equal('GIFT_WRAP', gift_wrap.sku)

        pricing_sku = Pricing::Sku.find('GIFT_WRAP')
        assert_equal('001', pricing_sku.tax_code)
        assert_equal(5.5.to_m, pricing_sku.prices.first.regular)
      end

      def test_update
        gift_wrap = create_gift_wrap(name: 'Test', sku: 'TEST_WRAP')

        patch admin.catalog_gift_wrap_path(gift_wrap),
              params: {
                gift_wrap: { name: 'Changed' }
              }

        assert_redirected_to(admin.catalog_gift_wraps_path)

        gift_wrap.reload
        assert_equal('Changed', gift_wrap.name)
      end

      def test_destroy
        gift_wrap = create_gift_wrap(name: 'Test', sku: 'TEST_WRAP')

        delete admin.catalog_gift_wrap_path(gift_wrap)

        assert_redirected_to(admin.catalog_gift_wraps_path)
        assert_equal(0, Catalog::GiftWrap.count)
      end
    end
  end
end
