class Commission < ActiveRecord::Base
  attr_accessible :chamber, :name, :deputy_ids, :president_id, :secretary_ids, :member_ids

  has_many :commission_memberships
  has_many :deputies, through: :commission_memberships

  has_and_belongs_to_many :initiative_steps

  VALID_CHAMBERS = ["deputies", "senators"]

  validates_inclusion_of :chamber, in: VALID_CHAMBERS

  def president
    self.deputies.where("commission_memberships.position = ?", "president").first
  end

  def president_id
    self.president.try(:id)
  end

  def president_id=(id)
    self.commission_memberships.where(position: "president").delete_all
    self.commission_memberships.build(position: "president", deputy_id: id)
  end

  def secretaries
    self.deputies.where("commission_memberships.position = ?", "secretary")
  end

  def secretary_ids
    self.secretaries.map(&:id)
  end

  def secretary_ids=(ids)
    self.commission_memberships.where(position: "secretary").delete_all
    Array(ids).each do |id|
      self.commission_memberships.build(position: "secretary", deputy_id: id)
    end
  end

  def members
    self.deputies.where("commission_memberships.position = ?", "member")
  end

  def member_ids=(ids)
    self.commission_memberships.where(position: "member").delete_all
    Array(ids).each do |id|
      self.commission_memberships.build(position: "member", deputy_id: id)
    end
  end

  def member_ids
    self.members.map(&:id)
  end
end
