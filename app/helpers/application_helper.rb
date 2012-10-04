module ApplicationHelper

  def title(text)
    content_for(:title) { "#{text} - Mi Congreso" }
  end
end
