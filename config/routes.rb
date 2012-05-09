GithubFriend::Application.routes.draw do

  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks" }
  devise_scope :member do
    get "sign_out" => "devise/sessions#destroy"
  end
  root :to => "home#index"

  get '/members/token', to: 'members/token#edit', :as => :user_token
  put '/members/token', to: 'members/token#update'

end
