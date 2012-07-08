class HTMLwithoutPTag < Redcarpet::Render::HTML

  def paragraph(text) # without <p></p>
    text
  end

end

