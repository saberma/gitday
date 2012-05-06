class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if current_user and current_user.token.blank?
      redirect_to user_token_path
    end
  end
end
