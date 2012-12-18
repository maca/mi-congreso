class District < ActiveRecord::Base
  attr_accessible :number, :state_id

  belongs_to  :state
  has_many    :sections
  has_one     :member

  def name
    "#{number} - #{state.name}"
  end
end
