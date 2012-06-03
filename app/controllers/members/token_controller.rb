class Members::TokenController < ApplicationController

  def update
    current_member.update_attributes token: params[:member][:token]
    redirect_to root_path, notice: "Update success!"
  end

end
