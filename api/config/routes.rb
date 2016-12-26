Rails.application.routes.draw do
  devise_scope :user do
    get '/user/auth/:provider/remove', to: 'users/omniauth_callbacks#remove'
    get '/user/is_signed_in', to: 'users/sessions#is_signed_in', as: 'is_signed_in'
  end

  devise_for :user, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  constraints(-> (req) { req.env["HTTP_USER_AGENT"] =~ /(facebookexternalhit|Twitterbot|Pinterest|Google.*snippet|Tumblr)/ }) do
    get 'detalhe/card/:id', to: 'share#card'
    get 'perfil/:username', to: 'share#profile'
    get 'personagem/:username', to: 'share#profile'

    root to: 'welcome#index'
  end

  namespace :api do
    get '/ramona/follow', to: 'general#follow', username: :ramona
    get '/ramona/unfollow', to: 'general#unfollow', username: :ramona
    get '/ramona/(:page)/(:quantity)', to: 'general#editors', username: :ramona, defaults: { page: 1, quantity: 10 }
    get '/ramona/(:page)/(:quantity)', to: 'general#editors', username: :ramona, defaults: { page: 1, quantity: 10 }
    get '/user/:username/profile', to: 'general#profile'
    get '/user/:username/liked', to: 'general#liked'
    get '/user/:username/recommended/:editor/(:page)/(:quantity)', to: 'general#recommended'
    get '/user/:username/(:page)/(:quantity)', to: 'general#users', defaults: { page: 1, quantity: 10 }
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
        get :patterns
        post :delete
      end
    end
  end

  namespace :admin do
    namespace :remix do
      resources :background_colors, except: [:show]
      resources :text_colors, except: [:show]
      resources :stickers, except: [:show, :edit]
      resources :patterns, except: [:show, :edit]
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
  get '/remix/detail/:id' => 'remix#detail', as: 'remix_image_detail'

  root to: 'welcome#index'

  get "*path" => 'welcome#index'
end

