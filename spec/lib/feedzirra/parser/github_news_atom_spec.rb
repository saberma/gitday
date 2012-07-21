require 'spec_helper'

describe Feedzirra::Parser::GithubNewsAtomEntry do

  let(:file) { "user_and_repo_entries.xml" }

  let(:feed) { parse file }

  context 'user entries' do

    it 'should be get' do
      feed.user_entries.first.event.should eql 'WatchEvent'
    end

  end

  context 'repo entries' do

    it 'should be get' do
      feed.repo_entries.first.event.should eql 'IssueCommentEvent'
    end

  end

end
