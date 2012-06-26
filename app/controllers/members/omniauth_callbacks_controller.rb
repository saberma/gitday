class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    # You need to implement the method below in your model
    @member = Member.find_for_github_oauth(request.env["omniauth.auth"], current_member)

    if @member.persisted?
      @member.remember_me = true
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
      sign_in_and_redirect @member, :event => :authentication
    else
      session["devise.github"] = request.env["omniauth.auth"]
      redirect_to new_member_registration_url
    end
  end

  protected
  def after_omniauth_failure_path_for resource
    root_path
  end

end
