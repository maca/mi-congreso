class District < ActiveRecord::Base
  attr_accessible :number, :state_id

  belongs_to  :state
  has_many    :sections
  has_one     :deputy

  def name
    "#{number} - #{state.name}"
  end
end
