require 'spec_helper'

describe RepositoryController do

  let(:entry) { FactoryGirl.create(:pushed_to_branch, published_at: Time.now) }

  before do
    entry.generate
  end

  describe "GET 'show'" do
    render_views

    it "returns http success" do
      get 'show', fullname: 'rails/rails'
      response.body.should include 'pushed to'
    end

  end

end
