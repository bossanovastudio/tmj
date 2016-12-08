Rails.application.routes.draw do
  scope '/api' do
    mount_devise_token_auth_for 'User', at: 'auth'

    get '/ramona/(:page)/(:quantity)', to: 'general#editors', id: :ramona, defaults: { page: 1, quantity: 10 }
    get '/all/(:page)/(:quantity)', to: 'general#all', defaults: { page: 1, quantity: 10 }
    get '/all_without_editors/(:page)/(:quantity)', to: 'general#all_without_editors', defaults: { page: 1, quantity: 10 }

    get '/highlights', to: 'general#highlights'

    post '/register', to: 'castings#create'

    get '/castings/download', to: 'castings#download'

    resources :cards do
      member do
        get 'like'
        get 'unlike'
        get 'accept'
        get 'reject'
      end

      collection do
        get ':page/:quantity', to: 'cards#index', defaults: { page: 1, quantity: 10 }
        get :total
      end
    end

    resources :remix, only: :create do
      collection do
        get :categories
        get "categories/:id", action: :images
        get :backgrounds
        get :text_colors
        get :stickers
      end
    end

    resources :images
    resources :videos
  end

  root :to => proc { |env| [ 200, {}, ['.'] ] }
end
