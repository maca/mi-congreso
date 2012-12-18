class State < ActiveRecord::Base
  attr_accessible :name, :short_name

  belongs_to :region
  has_many :districts
end
