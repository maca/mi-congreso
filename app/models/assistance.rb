class Assistance < ActiveRecord::Base
  attr_accessible :deputy_id, :session_id, :value

  belongs_to :deputy
  belongs_to :session

  validates :deputy_id, :session_id, :value, presence: true
  validates_uniqueness_of :deputy_id, scope: :session_id

  def self.create_from_scraper(session, deputy_assistance)
    deputy = Deputy.find_by_name(deputy_assistance.name)

    if deputy
      self.create(deputy_id: deputy.id, session_id: session.id, value: AssistanceValue.to_i(deputy_assistance.value))
    end
  end
end