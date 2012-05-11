class HomeController < ApplicationController
  skip_before_filter :authenticate_member!

  def index
    if current_member
      if current_member.token.blank?
        redirect_to member_token_path
      else
        @day = current_member.days.first || current_member.days.new
        @entries = @day.entries
        @watchings = @day.watchings
        @followings = @day.followings
        render :action => "dashboard" and return
      end
    end
  end
end
