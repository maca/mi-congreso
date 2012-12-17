class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :number,        null: false
      t.integer :district_id,   null: false
    end

    add_index :sections, :district_id
  end
end
