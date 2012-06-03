class Members::SubscribeController < ApplicationController

  def create
    current_member.update_attribute :subscribed, true
    redirect_to root_path, notice: "Subscribe success!"
  end

  def update
    current_member.update_attribute :subscribed, false
    redirect_to root_path, notice: "Unsubscribe success!"
  end

end
