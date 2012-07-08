module ApplicationHelper

  def markdown
    @markdown ||= Redcarpet::Markdown.new(HTMLwithoutNewline, autolink: true)
  end

end
