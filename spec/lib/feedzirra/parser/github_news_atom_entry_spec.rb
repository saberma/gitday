require 'spec_helper'

describe Feedzirra::Parser::GithubNewsAtomEntry do

  let(:feed) do
    parse file
  end

  let(:entry) do
    feed.entries.first
  end

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

  context 'CommentEvent' do

    let(:file) { "comment_event.xml" }

    it 'should be parse' do
      entry.link.should eql 'blueimp/jQuery-File-Upload/issues/1223#issuecomment-6733474'
    end
  end

end

def parse(file)
  feed = Feedzirra::Feed.parse(File.open(Rails.root.join("spec/factories/data/#{file}"), 'r').read)
  feed.etag = 'foo_etag'
  feed
end
