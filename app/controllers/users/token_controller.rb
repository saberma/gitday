class Users::TokenController < ApplicationController
  def update
    current_user.update_attributes token: params[:user][:token]
    redirect_to root_path
  end
end
