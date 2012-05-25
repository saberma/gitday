require 'spec_helper'

describe User do

  context '#blog' do

    it 'should start with http://' do
      u = User.new blog: 'saberma.me'
      u.blog.should eql 'http://saberma.me'
      u.blog = 'http://saberma.me'
      u.blog.should eql 'http://saberma.me'
      u.blog = 'https://saberma.me'
      u.blog.should eql 'https://saberma.me'
    end

    context 'is nil' do

      it 'should not raise error' do
        expect do
          u = User.new
          u.blog
        end.should_not raise_error
      end

    end

  end

end
