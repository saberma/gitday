class HomeController < ApplicationController
  skip_before_filter :authenticate_member!, only: [:index]

  def index
    if current_member
      if current_member.token.blank?
        redirect_to member_token_path, notice: "Please provide your Github News Feed token!"
      elsif current_member.token == Member::FAKE_TOKEN
        redirect_to member_token_path, notice: "#{Member::FAKE_TOKEN} is an example token, DO NOT use it!"
      else
        day
      end
    end
  end

  def day
    @day = current_member.days.find_by_number(params[:number]) unless params[:number].blank?
    @day ||= current_member.days.first || current_member.days.new
    @active_repositories = @day.active_repositories
    @watchings = @day.watchings
    @followings = @day.followings
    @watchers = @day.watchers
    @followers = @day.followers
    @empty = [@active_repositories, @watchings, @followings, @watchers, @followers].map(&:empty?).all?
    render :action => "dashboard" and return
  end

  def mail
    @day = current_member.days.latest
    @active_repositories = @day.active_repositories
    @watchings = @day.watchings
    @followings = @day.followings
    @watchers = @day.watchers
    @followers = @day.followers
    @empty = [@active_repositories, @watchings, @followings, @watchers, @followers].map(&:empty?).all?
    render 'subscriber/day', layout: nil
  end
end
