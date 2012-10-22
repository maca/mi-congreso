class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer     :value, limit: 1
      t.references  :initiative
      t.references  :session
      t.references  :voter, polymorphic: true

      t.timestamps
    end

    add_index :votes, :value
    add_index :votes, :initiative_id
    add_index :votes, :session_id
    add_index :votes, [:voter_id, :voter_type]
  end
end
