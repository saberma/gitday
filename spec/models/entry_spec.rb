require 'spec_helper'

describe Entry do

  let(:member) { Factory(:member) }

  let(:day) { Factory(:day, member: member) }

  context 'comment' do

    let(:entry) { Factory(:comment_on_jquery_file_upload_entry, day: day) }

    it 'should get repo' do
      entry.active_repository.should eql 'blueimp/jQuery-File-Upload'
    end

    it 'should get the issue id' do
      entry.issue_number.should eql 1223
    end

    it 'should get the id' do
      entry.comment_id.should eql 6733474
    end

  end

  context 'push' do

    context '#create' do

      let(:feed_entry) { parse("push_event.xml").entries.first }

      let(:entry) { day.entries.first }

      before do
        day.entries.add feed_entry
      end

      it 'should be success' do
        entry.link.should eql 'elasticsearch/elasticsearch/compare/aafa8cc905...a5e541351f'
        entry.ref.should eql '0.19'
        entry.shas.should eql ['a5e5413']
      end

    end

  end

end
