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
    if member = self.find_by_email(data.email)
      member
    else # Create a member with a stub password. 
      self.create!(:email => data.email, :login => data.login)
    end
  end

  def self.generate_daily_report
    Member.all.each do |member|
      member.days.in_a_week.each(&:generate)
    end
  rescue => e
    ExceptionNotifier::Notifier.background_exception_notification(e)
    raise e
  end

  def self.get_news_feed
    Member.all.each do |member|
      name = member.login
      token = member.token
      unless token.blank?
        url = "https://github.com/#{name}.private.atom?token=#{token}"

        key = "github_#{name}"
        feed = Feedzirra::Feed.fetch_and_parse(url)
        unless feed.is_a?(Integer) # 发生错误时feed为错误码
          if feed.etag != member.etag
            Member.transaction do
              feed.entries.reverse_each do |entry|
                day = member.days.get entry.published
                unless day.entries.exists?(short_id: entry.short_id)
                  puts "set:#{entry.title}"
                  day.entries.create({
                    :short_id => entry.short_id,
                    :published_at => entry.published,
                    :link => entry.link,
                    #:title => entry.title,
                    :author => entry.author.name,
                    #:author_email => author.email,
                    #:author_uri => author.uri,
                    #:content => entry.content,
                    #:thumbnail => entry.thumbnail
                  })
                end
              end
              member.etag = feed.etag
              member.save
            end
          end
        end
      end
    end
  rescue => e
    ExceptionNotifier::Notifier.background_exception_notification(e)
    raise e # terminal daemon
  end

end
