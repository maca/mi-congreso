class Section < ActiveRecord::Base
  attr_accessible :district_id, :number

  belongs_to :district
end
