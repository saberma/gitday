class Members::TokenController < ApplicationController

  def update
    if current_member.update_attributes token: params[:member][:token], time_zone: params[:member][:time_zone]
      redirect_to root_path, notice: "Update success!"
    else
      flash.now[:error] = 'Update failure!'
      render action: :edit
    end
  end

end
