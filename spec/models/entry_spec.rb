require 'spec_helper'

describe Entry do

  context 'comment' do

    let(:entry) { Factory(:comment_on_jquery_file_upload_entry) }

    it 'should get repo' do
      entry.activity_repository.should eql 'blueimp/jQuery-File-Upload'
    end

    it 'should get the id' do
      entry.comment_id.should eql 6733474
    end

  end

end
