class HomeController < ApplicationController
  skip_before_filter :authenticate_member!

  def index
    if current_member
      if current_member.token.blank?
        redirect_to member_token_path
      else
        @entries = current_member.entries
        render :action => "dashboard" and return
      end
    end
  end
end
