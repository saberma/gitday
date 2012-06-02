GithubFriend::Application.routes.draw do

  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks" }
  devise_scope :member do
    get "sign_out" => "devise/sessions#destroy"
  end
  root :to => "home#index"

  get '/mail', to: 'home#mail' # just for mail test
  get '/members/token', to: 'members/token#edit', :as => :member_token
  put '/members/token', to: 'members/token#update'

  get '/members/unsubscribe', to: 'members/subscriber#update', :as => :member_unsubscribe
  get '/members/subscribe', to: 'members/subscriber#create', :as => :member_subscribe

end
