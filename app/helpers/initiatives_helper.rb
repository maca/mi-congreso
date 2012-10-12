module InitiativesHelper

  def subjects(initiative)
    initiative.subjects.map(&:name).join(", ")
  end

  def link_to_sort(text, sort, options={})
    options[:class] = [options[:class], "active"].join(" ") if sort == params[:order]
    link_to text, initiatives_path(order: sort), options
  end
end
