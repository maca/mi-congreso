class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.integer :party_id
      t.string :comission
      t.integer :state_id
      t.string :election_type
      t.string :birthplace
      t.datetime :birthdate
      t.string :substitute
      t.text :education
      t.text :political_experience
      t.text :private_experience

      t.timestamps
    end

    add_index :members, :party_id
    add_index :members, :state_id
  end
end
