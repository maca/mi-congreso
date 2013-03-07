class AddDraftToInitiative < ActiveRecord::Migration
  def change
    add_column :initiatives, :draft, :boolean, default: false
    add_index :initiatives, :draft
  end
end
