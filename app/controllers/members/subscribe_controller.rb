class Members::SubscribeController < ApplicationController

  def create
    current_member.update_attributes subscribed: true
    flash['notice'] = "subscribe success!"
    redirect_to root_path
  end

  def update
    current_member.update_attributes subscribed: false
    flash['notice'] = "unsubscribe success!"
    redirect_to root_path
  end

end
