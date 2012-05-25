require 'spec_helper'

describe Follower do

  let(:camelsong) { Factory(:camelsong) }

  let(:day) { Factory(:day) }

  let(:following_saberma_entry) { Factory(:following_saberma_entry, day: day) }

  let(:following_saberma_again_entry) { Factory(:following_saberma_again_entry, day: day) }

  let(:member) { day.member }

  context 'somebody follow saberma' do

    before do
      [camelsong, following_saberma_entry]
    end

    context 'somebody cancel and follow saberma again' do

      it 'should be ignore' do
        expect do
          following_saberma_again_entry
          day.generate
        end.should change(Follower, :count).by(1)
      end

    end

  end

end
