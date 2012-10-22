class Vote < ActiveRecord::Base
  attr_accessible :initiative, :session, :value, :voter, :initiative_id, :voter_id, :voter_type, :session_id

  belongs_to :initiative
  belongs_to :session
  belongs_to :voter, polymorphic: true

  validates_uniqueness_of :initiative_id, scope: [:voter_id, :voter_type]

  def value=(vote_type)
    if vote_type.is_a?(Symbol)
      vote_type = case vote_type
                  when :for then 1
                  when :against then 2
                  when :neutral then 3
                  when :absent then 4
                  end
    end
    write_attribute(:value, vote_type)
  end
end
