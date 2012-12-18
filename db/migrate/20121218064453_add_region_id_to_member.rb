class AddRegionIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :region_id, :integer
    add_index :members, :region_id
  end
end
