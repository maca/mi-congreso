module Sorting

  def sort_order(order)
    if order.to_s =~ /^([\w\_\.]+)_(desc|asc)$/
      self.order("#{$1} #{$2}")
    else
      self
    end
  end
end

ActiveRecord::Relation.send(:include, Sorting)