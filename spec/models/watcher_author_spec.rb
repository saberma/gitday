require 'spec_helper'

describe WatcherAuthor do

  let(:member) { Factory(:member) }

  let(:shopqi) { Factory(:shopqi) }

  let(:camelsong) { Factory(:camelsong) }

  let(:watching_shopqi_entry) { Factory(:watching_shopqi_entry, member: member) }

  let(:forked_shopqi_entry) { Factory(:forked_shopqi_entry, member: member) }

  context 'somebody watched shopqi' do

    before do
      [camelsong, shopqi, watching_shopqi_entry]
    end

    context 'somebody also forked shopqi' do

      it 'should be ignore' do
        expect do
          forked_shopqi_entry.generate
        end.should change(WatcherAuthor, :count).by(1)
      end

    end

  end

end
