class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.integer :number,    null: false
      t.integer :state_id,  null: false
    end

    add_index :districts, :state_id
  end
end
