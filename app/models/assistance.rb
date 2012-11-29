class Assistance < ActiveRecord::Base
  attr_accessible :member_id, :value

  validates :member_id, :session_id, :value, presence: true
end