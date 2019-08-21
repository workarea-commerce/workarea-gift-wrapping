module Workarea
  module GiftWrapping
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::GiftWrapping

      config.to_prepare do
        Storefront::Checkout::ShippingViewModel.send(
          :include,
          Storefront::Checkout::GiftOptionsViewModel
        )

        if Plugin.installed?('split_shipping')
          Storefront::Checkout::SplitShippingViewModel.send(
            :include,
            Storefront::Checkout::GiftOptionsViewModel
          )
        end
      end
    end
  end
end
