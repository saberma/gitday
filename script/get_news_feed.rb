require 'feedzirra'
require 'ap'

Feedzirra::Feed.add_feed_class Feedzirra::Parser::GithubNewsAtom

while true
  User.all.each do |user|
    #username = 'saberma'
    #token = '8bf8d2e49af6b90b5bab180e51e4e5cf'
    username = user.login
    token = user.token
    unless token.blank?
      url = "https://github.com/#{username}.private.atom?token=#{token}"

      key = "github_#{username}"
      feed = Feedzirra::Feed.fetch_and_parse(url)
      unless feed.is_a?(Integer) # 发生错误时feed为错误码
        if feed.etag != user.etag
          User.transaction do
            feed.entries.reverse_each do |entry|
              unless user.entries.exists?(short_id: entry.short_id)
                puts "set:#{entry.title}"
                author =  entry.author
                user.entries.create({
                  :short_id => entry.short_id,
                  :link => entry.link,
                  :title => entry.title,
                  :author_name => author.name,
                  :author_email => author.email,
                  :author_uri => author.uri,
                  :content => entry.content
                })
              end
            end
            user.update_attributes :etag => feed.etag
          end
        end
      end
    end
  end
  sleep 3
end
