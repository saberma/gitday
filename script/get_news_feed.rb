require 'feedzirra'
require 'ap'

Feedzirra::Feed.add_feed_class Feedzirra::Parser::GithubNewsAtom

while true
  Member.all.each do |member|
    #name = 'saberma'
    #token = '8bf8d2e49af6b90b5bab180e51e4e5cf'
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
            member.update_attributes! :etag => feed.etag
          end
        end
      end
    end
  end
  sleep 3
end
