Rails.application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create' , :via => [:get, :post]
  match 'auth/failure', to: redirect('/') , :via => [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout' , :via => [:get, :post]
  resources :posts do
    resources :likes
    resources :comments
  end
  resources :users do
    post :requesting
    post :accepted
    post :declining
    resources :profiles
  end
  devise_for :users, :path => 'u', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'users#index'
  devise_scope :user do

end
end
