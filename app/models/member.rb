class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :state
  belongs_to :party

  field :name,      type: String
  field :email,     type: String
  field :district,  type: String

  def party_name
    self.party.try(:name)
  end

  def state_name
    self.state.try(:name)
  end

end
