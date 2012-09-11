class Party < ActiveRecord::Base
  attr_accessible :name, :short_name

  has_many :members
end
