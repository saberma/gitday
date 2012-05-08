class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable, :recoverable, :validatable
  devise :trackable, :rememberable, :omniauthable
  has_many :entries, order: 'id desc'

  # Setup accessible (or protected) attributes for your model
  attr_accessible :token, :login

  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    ap data
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password. 
      self.create!(:email => data.email, :login => data.login)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

end
