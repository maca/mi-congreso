class AddSectionIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :section_id, :integer
    add_index :users, :section_id
  end
end
