class CreateAssistances < ActiveRecord::Migration
  def change
    create_table :assistances do |t|
      t.integer :member_id
      t.integer :session_id
      t.integer :value

      t.timestamps
    end

    add_index :assistances, :member_id
    add_index :assistances, :session_id
  end
end
