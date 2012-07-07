require 'spec_helper'

describe Day do

  let(:member) { Factory(:member) }

  let(:day) { Factory(:day, member: member) }

  context 'generate' do

    context 'activities' do

      context 'issues' do

        context 'comments' do

          let(:issue_comment_entry) { Factory(:comment_on_jquery_file_upload_entry, day: day) }

          before do
            issue_comment_entry
          end

          it 'should be success' do
            expect do
              expect do
                day.generate
              end.should change(ActiveRepository, :count).by(1)
            end.should change(Activity, :count).by(1)
          end

        end

      end

    end

  end

end
