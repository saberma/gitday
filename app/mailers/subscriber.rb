class Subscriber < ActionMailer::Base
  default css: :email, from: "Github Friend <admin@github-friend.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscriber.day.subject
  #
  def day(member)
    return unless member.subscribed
    return unless member.login == 'saberma' # test first
    puts "sending for #{member.login}"
    @day = member.days.latest
    if @day
      @watchings = @day.watchings
      @followings = @day.followings
      @watchers = @day.watchers
      @followers = @day.followers
      @empty = [@watchings, @followings, @watchers, @followers].map(&:empty?).all?
      mail to: "#{member.login} <#{member.email}>", subject: "Day ##{@day.number}" unless @empty
    end
  end
end
