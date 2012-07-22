require 'spec_helper'

describe Activity do

  let(:repository) { FactoryGirl.create(:rails) }

  let(:user) { FactoryGirl.create(:saberma) }

  let(:activity_push) { FactoryGirl.create(:activity, event: 'PushEvent', published_at: 7.hours.ago, repository: repository, author: user) } # 2012-07-20 14:00:00 UTC

  let(:activity_comment) { FactoryGirl.create(:activity, event: 'IssueCommentEvent', published_at: Time.now, repository: repository, author: user) } # 2012-07-21 02:00:00 UTC

  before do
    Timecop.freeze(Time.local(2012, 7, 21, 10, 0, 0))
    [activity_push, activity_comment]
  end

  after { Timecop.return }

  context 'timezone' do

    it 'should be filter' do
      #Activity.all.each do |activity|
      #  puts activity.published_at
      #end
      repository.activities.today.size.should eql 1 # UTC
      puts repository.activities.on(Date.today, 'Beijing').to_sql
      repository.activities.on(Date.today, 'Beijing').size.should eql 2
    end

  end

end
