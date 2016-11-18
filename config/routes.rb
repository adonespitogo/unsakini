Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/app/*ngroute', to: 'web_base#app'
  # ng2 html5 pushState routes

  namespace :api, :defaults => { :format => :json } do
    resource :user
    resources :boards do
      resources :posts
    end
  end

end