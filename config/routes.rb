Rails.application.routes.draw do
  # devise_for :customers
  devise_for :customers, controllers: {
  sessions:      'customer/sessions',
  passwords:     'customer/passwords',
  registrations: 'customer/registrations'
}
  get 'clips/create'
  get 'clips/destroy'

 # devise_for :users
  devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

  get 'user_register_or_session', to: 'users#register_or_session'
  resources :events, only: [:index, :destroy,:new,  :edit, :update, :create, :show]
  get 'search_event', to: 'events#search'
  resources :users, only: [:show ,:edit, :update]
  resources :customers, only: [:show]


  root 'events#index'
 

  # 使い方のページ
  get 'how_to_use_for_user', to: 'users#user_how_to_use'
  get 'how_to_use_for_customer', to: 'customers#customer_how_to_use'

  resources :events do
  member do
    post "add", to: "clips#create"
    end
  end

  resources :clips, only: [:destroy]

# 複数ステップに分けてフォームの入力
# resources :orders, only: [:create, :show] do
#   new do
#     match 'step1', via: [:get, :post]
#     post 'step2'
#     post 'step3'
#     post 'confirm'
#   end
# end
end
