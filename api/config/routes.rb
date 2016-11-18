Rails.application.routes.draw do
  scope '/api' do
    mount_devise_token_auth_for 'User', at: 'auth'

    resources :cards do
      member do
        get 'like'
        get 'unlike'
        get 'accept'
        get 'reject'
      end
      
      collection do
        get ':page/:quantity', to: 'cards#index', defaults: { page: 1, quantity: 10 }
      end
    end
    
    resources :images
    resources :videos
  end
  
  root :to => proc { |env| [ 200, {}, ['.'] ] }
end
