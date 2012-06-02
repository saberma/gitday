class HomeController < ApplicationController
  skip_before_filter :authenticate_member!

  def index
    if current_member
      if current_member.token.blank?
        redirect_to member_token_path
      else
        @day = current_member.days.latest || current_member.days.new
        @watchings = @day.watchings
        @followings = @day.followings
        @watchers = @day.watchers
        @followers = @day.followers
        @empty = [@watchings, @followings, @watchers, @followers].map(&:empty?).all?
        render :action => "dashboard" and return
      end
    end
  end

  def mail
    @day = current_member.days.latest
    @watchings = @day.watchings
    @followings = @day.followings
    @watchers = @day.watchers
    @followers = @day.followers
    @empty = [@watchings, @followings, @watchers, @followers].map(&:empty?).all?
    render 'subscriber/day', layout: nil
  end
end
