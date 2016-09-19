Rails.application.routes.draw do
  resources :cards

  root 'dashboard#index'
end
