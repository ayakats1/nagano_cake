Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  root to: 'public/homes#top'

  namespace :admin do
    root to: 'homes#top'
    resources :customers
    resources :genres
    resources :orders
    resources :items
    resources :order_details, only: [:update]
  end
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    #root to: 'homes#top'
    get '/' => 'homes#top'
    get 'about' => 'homes#about'
    resources :items

    resource :customers, only:[:index, :update]
    get 'customers/edit/information' => 'customers#edit'
    patch 'customers/my_page' => 'customers#update'
    get 'customers/my_page' => 'customers#show'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/unsubscribe' => 'customers#withdraw'

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items

    get 'orders/complate' => 'orders#complate'
    resources :orders
    post 'orders/comfirm' => 'orders#comfirm'

    resources :addresses
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
