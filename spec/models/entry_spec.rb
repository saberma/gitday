require 'spec_helper'

describe Entry do

  let(:member) { Factory(:member) }

  let(:day) { Factory(:day, member: member) }

  let(:entry) { day.entries.first }

  before do
    day.entries.add feed_entry
  end

  context 'comment' do

    let(:feed_entry) { parse("comment_event.xml").entries.first }

    it 'should be create' do
      entry.active_repository.should eql 'blueimp/jQuery-File-Upload'
      entry.issue_number.should eql 1223
      entry.comment_id.should eql 6733474
    end

  end

  context 'push' do

    let(:feed_entry) { parse("push_event.xml").entries.first }

    it 'should be create' do
      entry.link.should eql 'elasticsearch/elasticsearch/compare/aafa8cc905...a5e541351f'
      entry.ref.should eql '0.19'
      entry.shas.should eql ['a5e5413']
    end

  end

end
