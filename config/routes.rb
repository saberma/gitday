GithubFriend::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get "sign_out" => "devise/sessions#destroy"
  end
  root :to => "home#index"

  get '/users/token', to: 'users/token#edit', :as => :user_token
  put '/users/token', to: 'users/token#update'

end
