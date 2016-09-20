Rails.application.routes.draw do
  scope '/api' do
    resources :cards
    resources :images
    resources :videos
  end
end
