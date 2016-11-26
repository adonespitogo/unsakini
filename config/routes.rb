Rails.application.routes.draw do

  post 'api/auth_token' => 'api/auth_token#create'
  root to: 'web_base#index'

  # ng2 html5 pushState routes
  get 'app', to: 'web_base#app'
  get 'app/*ngroute', to: 'web_base#app'

  namespace :api do

    resource :user
    resources :boards do
      resources :posts do
        resources :comments, only: [:index, :create, :update, :destroy]
      end
    end

    post '/api/share/board/', to: 'share_board#index', as: 'share_board'
    get  '/api/users/search', to: 'users#search', as: 'user_search'

  end

end
