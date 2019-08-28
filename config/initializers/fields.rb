Workarea::Configuration.define_fields do
  fieldset 'Checkout', namespaced: false do
    field 'Gift Message Max Length',
      type: :integer,
      default: 500,
      description: 'Maximum length allowed for order gift messages'
  end
end
