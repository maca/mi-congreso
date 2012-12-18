class AddDistrictIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :district_id, :integer
    add_index :members, :district_id
  end
end
