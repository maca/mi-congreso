module InitiativesHelper

  def subjects(initiative, options={})
    if initiative.subjects.present?
      initiative.subjects.map do |subject|
        content_tag(options[:tag], subject.name, class: options[:class])
      end.join.html_safe
    end
  end

  def link_to_sort(text, sort, options={})
    options[:class] = [options[:class], "active"].join(" ") if sort == params[:order]
    link_to text, initiatives_path(order: sort), options
  end
end
