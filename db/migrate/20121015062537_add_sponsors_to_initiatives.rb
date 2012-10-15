class AddSponsorsToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :other_sponsor, :string
    add_column :initiatives, :sponsors_count, :integer, default: 0

    create_table :initiatives_members, id: false do |t|
      t.integer :initiative_id
      t.integer :member_id
    end

    add_index :initiatives_members, :initiative_id
    add_index :initiatives_members, :member_id
  end
end
