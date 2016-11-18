Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'api/auth'

  # ng2 html5 pushState routes
  get '/app/*ngroute', to: 'web_base#app'

  namespace :api do
    resource :user
    resources :boards do
      resources :posts do
        resources :comments, only: [:index, :create, :update, :destroy]
      end
    end

    post '/api/share/board/', to: 'share_board#index', as: 'share_board'

  end


end
