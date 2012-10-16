class Subject < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :initiatives

  validates :name, presence: true

  scope :popular, -> { where{initiatives_count > 0}.order("initiatives_count DESC") }

  def calculate_initiatives_count
    self.initiatives_count = self.initiatives.count
  end

  def calculate_initiatives_count!
    self.calculate_initiatives_count
    self.save
  end
end