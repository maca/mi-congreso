class AddRegionIdToState < ActiveRecord::Migration
  def change
    add_column :states, :region_id, :integer
    add_index :states, :region_id
  end
end
