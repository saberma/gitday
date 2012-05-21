require 'spec_helper'

describe WatcherAuthor do

  let(:shopqi) { Factory(:shopqi) }

  let(:camelsong) { Factory(:camelsong) }

  let(:day) { Factory(:day) }

  let(:watching_shopqi_entry) { Factory(:watching_shopqi_entry, day: day) }

  let(:forked_shopqi_entry) { Factory(:forked_shopqi_entry, day: day) }

  let(:member) { day.member }

  context 'somebody watched shopqi' do

    before do
      [camelsong, shopqi, watching_shopqi_entry]
    end

    context 'somebody also forked shopqi' do

      it 'should be ignore' do
        expect do
          forked_shopqi_entry
          day.generate
        end.should change(WatcherAuthor, :count).by(1)
      end

    end

  end

end
