Rails.application.routes.draw do
  root to: "public/homes#top"
  get "home/about" => "public/homes#about"
  get "/customers/confirmation" => "public/customers#confirmation"
  patch "/customers/withdraw" => "public/customers#withdraw"
  delete "/cart_items/destroy_all" => "public/cart_items#destroy_all"
  get "/orders/:id/confirmation" => "public/orders#confirmation"
  get "/orders/thanks" => "public/orders#thanks"

  namespace :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  get "/admin" => "admin/homes#top"

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
