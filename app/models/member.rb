class Member < ActiveRecord::Base
  FAKE_TOKEN = '8bf2milj9236b90b53mds80e5123dmlf'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable, :recoverable, :validatable
  devise :trackable, :rememberable, :omniauthable
  has_many :days   , dependent: :destroy, order: 'id desc', extend: Day::Extension

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :token, :login, :time_zone
  validates :token, :time_zone, length: { maximum: 32 }
  validates_presence_of :token, on: :update

  before_validation do
    self.token.sub!(/.*token=/, '').strip! if token_changed?
  end

  def token_valid?
    !self.token.blank? and self.token != Member::FAKE_TOKEN
  end

  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if member = self.find_by_login(data.login)
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

  def self.send_daily
    Member.all.each do |member|
      if Time.now.in_time_zone(member.time_zone).hour >= 7 # 07.00 am
        if !member.email.blank? and member.token_valid? and member.subscribed and (day = member.days.latest) and !day.sended
          empty = [day.watchings, day.followings, day.watchers, day.followers].map(&:empty?).all?
          unless empty
            Subscriber.day(member).deliver!
            day.update_attributes! sended: true
          end
        end
      end
    end
  rescue => e
    ExceptionNotifier::Notifier.background_exception_notification(e)
    raise e
  end

  def self.get_news_feed
    Member.all.each do |member|
      if member.token_valid?
        url = "https://github.com/#{member.login}.private.atom?token=#{member.token}"
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
