require 'spec_helper'

describe Feedzirra::Parser::GithubNewsAtomEntry do

  let(:feed) { parse file }

  context 'User' do

    let(:entry) { feed.user_entries.first }

    context 'CreateEvent' do

      context 'Tag' do

        let(:file) { "create_event_tag.xml" }

        it 'should be ignore' do
          entry.should be_nil
        end

      end

      context 'Branch' do

        let(:file) { "create_event_branch.xml" }

        it 'should be ignore' do
          entry.should be_nil
        end

      end

    end

    context 'ForkEvent' do

      let(:file) { "fork_event.xml" }

      context '#link' do

        it 'should not start with whitespace' do
          entry.link.should eql 'JSFixed/JSFixed'
        end

      end

    end

  end

  context 'Repository' do

    let(:entry) { feed.repo_entries.first }

    context 'CommentEvent' do

      let(:file) { "comment_issue_event.xml" }

      it 'should be parse' do
        entry.link.should eql 'rails/rails/issues/7034#issuecomment-7150761'
      end
    end

    context 'PushEvent' do

      let(:file) { "push_to_branch_event.xml" }

      it 'should be parse' do
        entry.link.should eql 'rails/rails/compare/089371ac23...a37b90caf4'
        entry.ref.should eql '3-2-stable'
        entry.shas.should eql ['a37b90c']
      end
    end

  end

end
