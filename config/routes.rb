Rails.application.routes.draw do
  resources :prizes do
    member do
      post 'draw'
      post 'remove_record'
    end
  end
  root 'prizes#index'
  resources :users
  namespace :api do
    post '/users/checkin' => 'users#checkin'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
