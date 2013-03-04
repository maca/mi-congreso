class CreateInitiativeSteps < ActiveRecord::Migration
  def change
    create_table :initiative_steps do |t|
      t.integer :initiative_id
      t.integer :step
      t.date    :start
      t.string  :chamber

      t.timestamps
    end

    add_index :initiative_steps, :initiative_id

    create_table :commissions_initiative_steps, id: false do |t|
      t.integer :commission_id
      t.integer :initiative_step_id
    end

    add_index :commissions_initiative_steps, [:commission_id, :initiative_step_id], name: "by_commission_id_and_initiative_step_id"
  end
end
