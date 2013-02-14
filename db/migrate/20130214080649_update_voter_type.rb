class UpdateVoterType < ActiveRecord::Migration
  def up
    Vote.update_all({voter_type: "Deputy"}, {voter_type: "Member"})
  end

  def down
    Vote.update_all({voter_type: "Member"}, {voter_type: "Deputy"})
  end
end
