Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ng2 html5 pushState routes
  get '/app/*ngroute', to: 'application#app'

end