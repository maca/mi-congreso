class Vote < ActiveRecord::Base
  attr_accessible :initiative, :session, :value, :voter, :initiative_id, :voter_id, :voter_type, :session_id

  belongs_to :initiative
  belongs_to :session
  belongs_to :voter, polymorphic: true

  validates_uniqueness_of :initiative_id, scope: [:voter_id, :voter_type]
  validates :value, :voter_id, :voter_type, presence: true
  validates_inclusion_of :value, in: 1..3

  def value=(vote_type)
    write_attribute(:value, VoteValue.to_i(vote_type))
  end

  def value_object
    @value_object ||= VoteValue.new(self.value)
  end
end