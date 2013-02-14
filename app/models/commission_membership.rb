class CommissionMembership < ActiveRecord::Base
  attr_accessible :commission_id, :deputy_id, :position

  belongs_to :deputy
  belongs_to :commission
end