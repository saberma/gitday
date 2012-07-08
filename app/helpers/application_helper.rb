module ApplicationHelper

  def markdown
    @markdown ||= Redcarpet::Markdown.new(HTMLwithoutPTag, autolink: true)
  end

end
