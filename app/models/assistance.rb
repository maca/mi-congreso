class Assistance < ActiveRecord::Base
  attr_accessible :member_id, :session_id, :value

  belongs_to :member
  belongs_to :session

  validates :member_id, :session_id, :value, presence: true

  def self.create_from_scraper(session, member_assistance)
    member = Member.find_by_name(member_assistance.name)

    if member
      self.create(member_id: member.id, session_id: session.id, value: AssistanceValue.to_i(member_assistance.value))
    end
  end
end