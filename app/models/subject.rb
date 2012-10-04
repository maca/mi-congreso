class Subject < ActiveRecord::Base
  attr_accessible :name

  has_many :initiatives

  validates :name, presence: true
end
