require 'spec_helper'

describe Member do

  let(:feed) do
    parse file
  end

  context 'FollowEvent' do

    context 'two members follow a same guy' do

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

end
