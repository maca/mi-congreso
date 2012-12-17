class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :number, null: false
    end
  end
end
