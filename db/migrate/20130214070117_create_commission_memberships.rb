class CreateCommissionMemberships < ActiveRecord::Migration
  def change
    create_table :commission_memberships do |t|
      t.string :position
      t.integer :commission_id
      t.integer :member_id

      t.timestamps
    end

    add_index :commission_memberships, :commission_id
    add_index :commission_memberships, :member_id
  end
end
