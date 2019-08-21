Workarea.append_partials(
  'storefront.checkout_shipping_fields',
  'workarea/storefront/checkouts/gift_message'
)

Workarea.append_partials(
  'storefront.checkout_shipping_step_form',
  'workarea/storefront/checkouts/gift_wrapping'
)

Workarea.append_partials(
  'storefront.checkout_cart_summary_item_details',
  'workarea/storefront/checkouts/gift_wrapping_summary'
)

Workarea.append_partials(
  'storefront.checkout_summary_shipping_attributes',
  'workarea/storefront/checkouts/gift_message_summary'
)

Workarea.append_partials(
  'storefront.order_summary_item_details',
  'workarea/storefront/orders/gift_wrapping'
)

Workarea.append_partials(
  'storefront.cart_summary_item_details',
  'workarea/storefront/orders/gift_wrapping'
)

Workarea.append_partials(
  'storefront.order_summary_shipping',
  'workarea/storefront/orders/gift_message'
)

Workarea.append_partials(
  'storefront.order_mailer_summary_order_details',
  'workarea/storefront/order_mailer/gift_wrapping'
)

Workarea.append_partials(
  'storefront.order_mailer_summary_shipping',
  'workarea/storefront/order_mailer/gift_message'
)

#
# ADMIN
#

Workarea.append_partials(
  'admin.catalog_menu',
  'workarea/admin/catalog_gift_wraps/navigation'
)

Workarea.append_partials(
  'admin.product_fields',
  'workarea/admin/catalog_products/gift_wrapping_fields'
)

Workarea.append_partials(
  'admin.shipping_details',
  'workarea/admin/shippings/gift_message'
)

Workarea.append_partials(
  'admin.order_attributes_item_details',
  'workarea/admin/orders/gift_wrapping'
)
