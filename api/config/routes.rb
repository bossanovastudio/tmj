Rails.application.routes.draw do
  devise_scope :user do
    get '/user/auth/:provider/remove', to: 'users/omniauth_callbacks#remove'
  end
  
  devise_for :user, :controllers => { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :api do
    get '/ramona/(:page)/(:quantity)', to: 'general#editors', id: :ramona, defaults: { page: 1, quantity: 10 }
    get '/all/(:page)/(:quantity)', to: 'general#all', defaults: { page: 1, quantity: 10 }
    get '/all_without_editors/(:page)/(:quantity)', to: 'general#all_without_editors', defaults: { page: 1, quantity: 10 }

    get '/highlights', to: 'general#highlights'

    post '/register', to: 'castings#create'

    get '/castings/download', to: 'castings#download'

    resources :cards,  only: [:create, :show] do
      member do
        get :like
        get :unlike
      end
    end
    
    resources :images, only: [:create]
    resources :videos, only: [:create]
    resources :remix,  only: [:create] do
      collection do
        get :categories
        get "categories/:id", action: :images
        get :backgrounds
        get :text_colors
        get :stickers
        post :delete
      end
    end
  end

  namespace :admin do
    namespace :remix do
      resources :background_colors, except: [:show]
      resources :text_colors, except: [:show]
      resources :stickers, except: [:show, :edit]
      resources :categories, except: [:show] do
        resources :images
      end

    end

    resources :cards do
      collection do
        post :accept
        post :reject
        get :total
      end
    end

    resources :casting, only: [:index] do
      collection do
        get :download
        get "categories/:id", action: :images
        get :backgrounds
        get :text_colors
        get :stickers
      end
    end

    resources :highlights do
      post 'move', on: :member
    end

    resources :images
    resources :videos

    root to: 'cards#index'
  end

  get "/participe" => 'welcome#register'
  get "/remix" => 'remix#index'
  get '/remix/image/:id' => 'remix#show', as: 'remix_image'

  root to: 'welcome#index'
  get "*path" => 'welcome#index'
end
