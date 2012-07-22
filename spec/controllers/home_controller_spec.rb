require 'spec_helper'

describe HomeController do

  let(:member) { Factory(:member) }

  let(:day) { Factory(:day, member: member) }

  let(:push_entry) { FactoryGirl.create(:pushed_to_branch, published_at: 7.hours.ago) }

  let(:comment_entry) { FactoryGirl.create(:comment, published_at: Time.now) }

  before do
    Timecop.freeze(Time.local(2012, 7, 21, 10, 0, 0))
    day
    sign_in(member)
    [push_entry, comment_entry].map(&:generate)
  end

  after { Timecop.return }

  describe "GET 'index'" do
    render_views

    it "returns http success" do
      get 'index'
      response.body.should include 'pushed to'
    end

  end

end
