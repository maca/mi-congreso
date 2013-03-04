class InitiativeStep < ActiveRecord::Base
  attr_accessible :chamber, :start, :step, :commission_ids

  belongs_to :initiative

  has_and_belongs_to_many :commissions
end
