module Workarea
  module Catalog
    class GiftWrap
      include ApplicationDocument

      field :name, type: String, localize: true
      field :sku, type: String
    end
  end
end
