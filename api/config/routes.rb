Rails.application.routes.draw do
  devise_for :user

  namespace :api do
    get '/ramona/(:page)/(:quantity)', to: 'general#editors', id: :ramona, defaults: { page: 1, quantity: 10 }
    get '/all/(:page)/(:quantity)', to: 'general#all', defaults: { page: 1, quantity: 10 }
    get '/all_without_editors/(:page)/(:quantity)', to: 'general#all_without_editors', defaults: { page: 1, quantity: 10 }

    get '/highlights', to: 'general#highlights'

    post '/register', to: 'castings#create'

    get '/castings/download', to: 'castings#download'

    resources :cards,  only: [:create]
    resources :images, only: [:create]
    resources :videos, only: [:create]
    resources :remix,  only: [:create] do
      collection do
        get :categories
        get "categories/:id", action: :images
        get :backgrounds
        get :text_colors
        get :stickers
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
      end
    end

    resources :highlights

    resources :images
    resources :videos

    root to: 'cards#index'
  end

  root :to => proc { |env| [ 200, {}, ['.'] ] }
end
