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

      let(:file) { "comment_event.xml" }

      it 'should be parse' do
        entry.link.should eql 'blueimp/jQuery-File-Upload/issues/1223#issuecomment-6733474'
      end
    end

    context 'PushEvent' do

      let(:file) { "push_event.xml" }

      it 'should be parse' do
        entry.link.should eql 'elasticsearch/elasticsearch/compare/aafa8cc905...a5e541351f'
        entry.ref.should eql '0.19'
        entry.shas.should eql ['a5e5413']
      end
    end

  end

end
