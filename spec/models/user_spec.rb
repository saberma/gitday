require 'spec_helper'

describe User do

  context '#company' do

    let(:user) { Factory.build(:saberma) }

    it 'should limit to 64' do
      user.company = "I make iOS apps that are lickable. Love to rant on startups. Speaker. Developer of http://pspdfkit.com."
      user.save
      user.reload.company.size.should eql 64
    end

  end

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
