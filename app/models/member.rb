class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable, :recoverable, :validatable
  devise :trackable, :rememberable, :omniauthable
  has_many :days   , dependent: :destroy, order: 'id desc', extend: Day::Extension

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :token, :login

  before_update do
    self.token.sub!("https://github.com/#{self.login}.private.atom?token=", '') if token_changed?
  end

  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    ap data
    if member = self.find_by_email(data.email)
      member
    else # Create a member with a stub password. 
      self.create!(:email => data.email, :login => data.login)
    end
  end

end
