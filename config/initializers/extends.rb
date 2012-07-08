class HTMLwithoutNewline < Redcarpet::Render::HTML

  def paragraph(text) # p
    text
  end

  def list(contents, list_type) # ul
    contents
  end

  def list_item(text, list_type) # li
    text
  end

  def block_code(code, language) # pre
    "<code>#{code}</code>"
  end

end

