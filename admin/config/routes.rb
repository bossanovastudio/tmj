Rails.application.routes.draw do
  resources :highlights

  resources :cards do
    collection do
      get ':page/:quantity', to: 'cards#index', defaults: { page: 1, quantity: 10 }, as: :paginate
      
      post :accept
      post :reject
    end
  end

  root 'cards#index'
end
