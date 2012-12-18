class Region < ActiveRecord::Base
  attr_accessible :number

  has_many :states

  def name
    number
  end
end
