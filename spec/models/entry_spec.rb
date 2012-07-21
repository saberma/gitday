require 'spec_helper'

describe Entry do

  context 'repo' do

    context '#create' do

      let(:entry) { Entry.first }

      before do
        Entry.add feed_entry
      end

      context 'comment' do

        let(:feed_entry) { parse("comment_event.xml").repo_entries.first }

        it 'should be success' do
          entry.repository.should eql 'blueimp/jQuery-File-Upload'
          entry.issue_number.should eql 1223
          entry.comment_id.should eql 6733474
        end

      end

      context 'push' do

        let(:feed_entry) { parse("push_event.xml").repo_entries.first }

        it 'should be success' do
          entry.link.should eql 'elasticsearch/elasticsearch/compare/aafa8cc905...a5e541351f'
          entry.ref.should eql '0.19'
          entry.shas.should eql ['a5e5413']
        end

      end

    end

    context '#generate' do

      let(:entry) { FactoryGirl.create(:pushed_to_elasticsearch) }

      it 'should be success' do
        entry
        expect do
          expect do
            entry.generate
          end.should change(Activity, :count).by(1)
        end.should change(Commit, :count).by(1)
      end

    end

  end

end
