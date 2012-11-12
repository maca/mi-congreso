module ApplicationHelper

  def title(text)
    content_for(:title) { "#{text} - Mi Congreso" }
  end

  def classes(css_classes)
    content_for(:classes) { css_classes }
  end

  def flash_messages
    return nil if flash.empty?

    flash.map do |type, message|
      type = :success if type.to_s == "notice"
      content_tag(:div, message, class: "alert-box #{type} margin-top")
    end.join.html_safe
  end
end
