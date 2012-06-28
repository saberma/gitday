class Subscriber < ActionMailer::Base
  default css: :email, from: "Gitday <admin@gitday.com>"

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
    mail from: "Gitday <admin@gitday.com>", to: "#{member.login} <#{member.email}>", subject: "Day ##{@day.number}"
  rescue Timeout::Error
    puts "connect error: #{entry.short_id}"
  end
end
