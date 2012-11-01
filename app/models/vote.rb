class Vote < ActiveRecord::Base
  attr_accessible :initiative, :session, :value, :voter, :initiative_id, :voter_id, :voter_type, :session_id

  belongs_to :initiative
  belongs_to :session
  belongs_to :voter, polymorphic: true

  validates_uniqueness_of :initiative_id, scope: [:voter_id, :voter_type]

  def value=(vote_type)
    write_attribute(:value, VoteValue.to_i(vote_type))
  end
end
