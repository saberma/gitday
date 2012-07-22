require 'spec_helper'

describe Follower do

  let(:member) { Factory(:member) }

  let(:camelsong) { Factory(:camelsong) }

  let(:following_saberma_entry) { Factory(:following_saberma_entry, member: member) }

  let(:following_saberma_again_entry) { Factory(:following_saberma_again_entry, member: member) }

  context 'somebody follow saberma' do

    before do
      [camelsong, following_saberma_entry]
    end

    context 'somebody cancel and follow saberma again' do

      it 'should be ignore' do
        expect do
          following_saberma_again_entry.generate
        end.should change(Follower, :count).by(1)
      end

    end

  end

end
