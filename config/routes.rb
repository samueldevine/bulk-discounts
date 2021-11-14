Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :bulk_discounts, only: [:index]
  end

  get "/merchants/:merchant_id/dashboard", to: "merchant_dashboards#index"

  get "/merchants/:merchant_id/items", to: "merchant_items#index"
  get "/merchants/:merchant_id/items/new", to: "merchant_items#new"
  post "/merchants/:merchant_id/items", to: "merchant_items#create"
  get "/merchants/:merchant_id/items/:item_id", to: "merchant_items#show"
  get "/merchants/:merchant_id/items/:item_id/edit", to: "merchant_items#edit"
  patch "/merchants/:merchant_id/items/:item_id", to: "merchant_items#update"

  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"



  patch "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant_invoices#update"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant_invoices#show"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merhcant_invoices#edit"

  patch "/merchants/:merchant_id/items", to: "merchant_items#update"

  resources :admin, only: [:index]

  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/new', to: 'admin_merchants#new'
  post '/admin/merchants', to: 'admin_merchants#create'
  get '/admin/merchants/:id', to: 'admin_merchants#show', as: :admin_merchants_show
  get '/admin/merchants/:id/edit', to: 'admin_merchants#edit', as: :admin_merchants_edit
  patch '/admin/merchants/:id', to: 'admin_merchants#update'

  get '/admin/invoices', to: 'admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin_invoices#show', as: :admin_invoices_show
  patch '/admin/invoices/:id', to: 'admin_invoices#update'
end
