class Subscriber < ActionMailer::Base
  default css: :email, from: "Github Friend <admin@github-friend.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscriber.day.subject
  #
  def day(member)
    puts "sending for #{member.login}"
    @day = member.days.latest
    @watchings = @day.watchings
    @followings = @day.followings
    @watchers = @day.watchers
    @followers = @day.followers
    mail from: "Github Friend <admin@github-friend.com>", to: "#{member.login} <#{member.email}>", subject: "Day ##{@day.number}"
  end
end
