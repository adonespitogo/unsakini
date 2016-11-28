Rails.application.routes.draw do

  root :to => "application#index"

  namespace :unsakini do
    #knock route
    post 'user_token' => 'user_token#create'
    # ng2 html5 pushState routes
    # get 'app', to: 'web#app'
    # get 'app/*ngroute', to: 'web#app'

    resource :user
    resources :boards do
      resources :posts do
        resources :comments, only: [:index, :create, :update, :destroy]
      end
    end

    post 'share/board/', to: 'share_board#index', as: 'share_board'
    get  'users/search', to: 'users#search', as: 'user_search'
    get  'user/confirm/:token', to: 'users#confirm', as: 'confirm_account'

  end

end
