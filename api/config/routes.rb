Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  scope '/api' do
    resources :cards do
      collection do
        get '(:page)/(:quantity)', to: 'cards#index', defaults: { page: 1, quantity: 10 }
      end
    end
    
    resources :images
    resources :videos
  end
  
  root :to => proc { |env| [ 200, {}, ['.'] ] }
end
