require 'spec_helper'

describe Repository do

  context 'create' do

    it 'should not duplicate' do
      Repository.get('zurb/foundation')
      Repository.where(fullname: 'zurb/foundation').size.should eql 1
    end

  end

  context 'destroyed' do

    it 'should be ignore' do
      expect do
        Repository.get('mbleigh/uifiddle')
      end.should_not raise_error(Octokit::NotFound)
    end

  end

end
