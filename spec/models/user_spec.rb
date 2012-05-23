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

  end

end
