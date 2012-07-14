require 'spec_helper'

describe Following do

  let(:member) { Factory(:member) }

  let(:camelsong) { Factory(:camelsong) }

  let(:ichord) { Factory(:ichord) }

  let(:day) { Factory(:day, member: member) }

  let(:following_camelsong_entry) { Factory(:following_camelsong_entry, day: day) }

  let(:following_camelsong_again_entry) { Factory(:following_camelsong_again_entry, day: day) }

  context 'somebody follow camelsong' do

    before do
      [camelsong, ichord, following_camelsong_entry]
    end

    context 'somebody cancel and follow camelsong again' do

      it 'should be ignore' do
        expect do
          following_camelsong_again_entry
          day.generate
        end.should change(FollowingAuthor, :count).by(1)
      end

    end

  end

end
