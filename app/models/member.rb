class Member < ActiveRecord::Base
  attr_accessible :birthdate, :birthplace, :comission, :education, :election_type, :email, :name, :party_id, :political_experience, :private_experience, :state_id, :substitute

  belongs_to :state
  belongs_to :party

  def party_name
    self.party.try(:name)
  end
 
  def state_name
    self.state.try(:name)
  end
end
