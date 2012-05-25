require 'spec_helper'

describe WatchingAuthor do

  let(:ajax_crud) { Factory(:ajax_crud) }

  let(:camelsong) { Factory(:camelsong) }

  let(:day) { Factory(:day) }

  let(:watching_ajax_crud_entry) { Factory(:watching_ajax_crud_entry, day: day) }

  let(:forked_ajax_crud_entry) { Factory(:forked_ajax_crud_entry, day: day) }

  let(:member) { day.member }

  context 'somebody watched AjaxCRUD' do

    before do
      [camelsong, ajax_crud, watching_ajax_crud_entry]
    end

    context 'somebody also forked AjaxCRUD' do

      it 'should be ignore' do
        expect do
          forked_ajax_crud_entry
          day.generate
        end.should change(WatchingAuthor, :count).by(1)
      end

    end

  end

end
