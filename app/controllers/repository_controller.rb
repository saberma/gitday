class RepositoryController < ApplicationController
  skip_before_filter :authenticate_member!
  def show
    @repository = Repository.find_by_fullname(params[:fullname])
    @activities = @repository.activities.today
  end
end
