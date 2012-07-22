require 'spec_helper'

describe Entry do

  context 'repo' do

    context '#create' do

      let(:entry) { Entry.first }

      before do
        Entry.add feed_entry
      end

      context 'comment' do

        let(:feed_entry) { parse("comment_issue_event.xml").repo_entries.first }

        it 'should be success' do
          entry.repository.should eql 'rails/rails'
          entry.issue_number.should eql 7034
          entry.comment_id.should eql 7150761
        end

      end

      context 'push' do

        let(:feed_entry) { parse("push_to_branch_event.xml").repo_entries.first }

        it 'should be success' do
          entry.link.should eql 'rails/rails/compare/089371ac23...a37b90caf4'
          entry.ref.should eql '3-2-stable'
          entry.shas.should eql ['a37b90c']
        end

      end

    end

    context '#generate' do

      context 'comment' do

        let(:issue_comment_entry) { Factory(:comment) }

        it 'should be success' do
          expect do
            expect do
              expect do
                expect do
                  issue_comment_entry.generate
                end.should change(Repository, :count)
              end.should change(Activity, :count).by(1)
            end.should change(Issue, :count).by(1)
          end.should change(IssueComment, :count).by(1)
        end

      end

      context 'push' do

        let(:entry) { FactoryGirl.create(:pushed_to_branch) }

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

end
