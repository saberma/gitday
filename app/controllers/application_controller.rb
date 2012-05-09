class ApplicationController < ActionController::Base
  before_filter :authenticate_member!
  protect_from_forgery
end
