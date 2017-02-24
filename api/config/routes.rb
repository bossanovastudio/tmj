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
    get 'remix/detalhe/:uid', to: 'share#remix'

    root to: 'welcome#index'
  end

  namespace :api do
    get '/user/:username/profile', to: 'general#profile'
    get '/user/:username/liked', to: 'general#liked'
    get '/user/:username/recommended/:editor/(:page)/(:quantity)', to: 'general#recommended'
    get '/user/:username/(:page)/(:quantity)', to: 'general#users', defaults: { page: 1, quantity: 10 }
    get '/all/(:page)/(:quantity)', to: 'general#all', defaults: { page: 1, quantity: 10 }
    get '/all_without_editors/(:page)/(:quantity)', to: 'general#all_without_editors', defaults: { page: 1, quantity: 10 }
    get '/:username/follow', to: 'general#follow'
    get '/:username/unfollow', to: 'general#unfollow'
    get '/:username/(:page)/(:quantity)', to: 'general#editors', defaults: { page: 1, quantity: 10 }
    get '/:username/(:page)/(:quantity)', to: 'general#editors', defaults: { page: 1, quantity: 10 }

    get '/highlights', to: 'general#highlights'

    get '/madebyyou/(:page)/(:quantity)', to: 'general#made_by_you', defaults: { page: 1, quantity: 10 }

    post '/register', to: 'castings#create'

    get '/page/:id', to: 'pages#index'

    get '/castings/download', to: 'castings#download'

    resources :cards,  only: [:create, :show] do
      member do
        get :like
        get :unlike
      end
    end

    resources :images, only: [:create]
    resources :videos, only: [:create]
    resources :remix_user_images, only: [:show]
    resources :remix,  only: [:create] do
      collection do
        get :categories
        get "categories/:id", action: :images
        get :backgrounds
        get :text_colors
        get :stickers
        get :patterns
        post :delete
        post :create_comic
      end
    end

    resources :profiles, only: [:index]
    resources :editor_providers, only: [:index]
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

    resources :editors do
      post ':id/commit_edit', action: :commit, on: :collection, as: :commit_edit
      post 'revoke', action: :revoke, on: :collection
      post 'promote', action: :promote, on: :collection
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
    resources :pages, only: [:index, :edit, :update]

    root to: 'cards#index'
  end

  get "/participe" => 'welcome#register'
  get "/remix" => 'remix#index'
  get '/remix/image/:uid' => 'remix#show', as: 'remix_image'
  get '/remix/detalhe/:uid' => 'remix#detail', as: 'remix_image_detail'

  root to: 'welcome#index'

  get "*path" => 'welcome#index'
end
