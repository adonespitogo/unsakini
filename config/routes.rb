Rails.application.routes.draw do
  
  root to: 'web_base#index'

  # ng2 html5 pushState routes
  get 'app', to: 'web_base#app'
  get 'app/*ngroute', to: 'web_base#app'


  namespace :api do

    mount_devise_token_auth_for 'User', at: 'auth'
    
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
