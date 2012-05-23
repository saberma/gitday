require 'spec_helper'

describe Entry do

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

  context 'two members follow a same guy', f: true do

    let(:member) { Factory(:member) }

    let(:member_camelsong) { Factory(:member_camelsong) }

    let(:file) { "short_id_unique_1.xml" }

    before do
      Feedzirra::Feed.stub!(:fetch_and_parse).and_return(feed)
      member
      Member.get_news_feed
    end

    context 'short_id is the same' do

      let(:file) { "short_id_unique_2.xml" }

      before do
        feed = parse file
        Feedzirra::Feed.stub!(:fetch_and_parse).and_return(feed)
        member_camelsong
      end

      it 'should be save' do
        expect do
          Member.get_news_feed
        end.should_not raise_error
      end

    end

  end

end

def parse(file)
  feed = Feedzirra::Feed.parse(File.open(Rails.root.join("spec/factories/data/#{file}"), 'r').read)
  feed.etag = 'foo_etag'
  feed
end
