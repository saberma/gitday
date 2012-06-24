Gitday::Application.routes.draw do

  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks" }
  devise_scope :member do
    get "sign_out" => "devise/sessions#destroy"
  end
  root :to => "home#index"

  get '/mail', to: 'home#mail' # just for mail test
  get '/member/token', to: 'members/token#edit', :as => :member_token
  put '/member/token', to: 'members/token#update'

  get '/member/unsubscribe', to: 'members/subscribe#update', :as => :member_unsubscribe
  get '/member/subscribe', to: 'members/subscribe#create', :as => :member_subscribe

end
