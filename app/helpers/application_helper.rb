module ApplicationHelper

  def title(text)
    content_for(:title) { "#{text} - Mi Congreso" }
  end

  def classes(css_classes)
    content_for(:classes) { css_classes }
  end

  def flash_messages
    return nil if flash.empty? && params[:message].blank?

    if flash.any?
      flash.map do |type, message|
        type = :success if type.to_s == "notice"
        content_tag(:div, message, class: "alert-box #{type} margin-top")
      end.join.html_safe
    elsif params[:message]
      content_tag(:div, t(params[:message], default: params[:message]), class: "alert-box margin-top")
    end
  end

  def twitter_timeline(username, widget_id)
    html = <<-HTML
      <a class="twitter-timeline" data-dnt=true href="https://twitter.com/#{h(username)}" data-widget-id="#{widget_id}">Tweets by @#{h(username)}</a>
      <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
    HTML
    html.html_safe
  end
end
