Rails.application.routes.draw do
  root to: 'public/homes#top'

  namespace :admin do
    root to: 'homes#top'
    resources :customers
    resources :genres
    resources :orders
    resources :items
  end
  namespace :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :addresses
    resources :orders
    resources :cart_items
    resources :customers
    resources :items
  end
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
