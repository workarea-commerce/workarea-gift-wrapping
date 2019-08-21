module Workarea
  module Storefront
    module Checkout
      module GiftOptionsViewModel
        extend ActiveSupport::Concern

        included do
          delegate :gift_message, to: :shipping, allow_nil: true
        end

        def gift_message?
          gift_message.present?
        end

        # Whether to show gift wrapping as an option in checkout.
        # Based on whether the Catalog has any configured gift wrap.
        #
        # @return [Boolean]
        #
        def offer_gift_wrapping?
          gift_wraps.any?
        end

        # An array of gift wrapping options from the Catalog.
        # First element is the name, second is the id.
        # Used in the gift wrap select on the shipping step.
        #
        # @return [Array<Array>]
        #
        def gift_wrapping_options
          @gift_wrapping_options ||=
            [['None', nil]] + gift_wraps.map do |gift_wrap|
              [gift_wrap.name, gift_wrap.id.to_s]
            end
        end

        private

        def gift_wraps
          @gift_wraps ||= Catalog::GiftWrap.all.to_a
        end
      end
    end
  end
end
