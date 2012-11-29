class Party < ActiveRecord::Base
  attr_accessible :name, :short_name, :official_id

  has_many :members
end