class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.string :name
      t.string :chamber

      t.timestamps
    end
  end
end
