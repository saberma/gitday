require 'spec_helper'

describe Repository do

  context 'destroyed' do

    it 'should be ignore' do
      expect do
        Repository.get('mbleigh/uifiddle')
      end.should_not raise_error(Octokit::NotFound)
    end

  end

end
