Rails.application.routes.draw do

  root to: 'unsakini/web#index'

  #knock route
  post 'unsakini/user_token' => 'user_token#create'

  # ng2 html5 pushState routes
  get 'unsakini/app', to: 'unsakini/web#app'
  get 'unsakini/app/*ngroute', to: 'unsakini/web#app'

  namespace :unsakini do

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
