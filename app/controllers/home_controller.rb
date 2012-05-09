class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if current_user
      if current_user.token.blank?
        redirect_to user_token_path
      else
        @entries = current_user.entries
        render :action => "dashboard" and return
      end
    end
  end
end
