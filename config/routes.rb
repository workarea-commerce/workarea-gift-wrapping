Workarea::Admin::Engine.routes.draw do
  scope '(:locale)', constraints: Workarea::I18n.routes_constraint do
    resources :catalog_gift_wraps, except: :show
  end
end
