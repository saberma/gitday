require 'spec_helper'

describe Entry do

  let(:feed) do
    Feedzirra::Feed.parse(File.open(Rails.root.join("spec/factories/data/#{file}"), 'r').read)
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

end
