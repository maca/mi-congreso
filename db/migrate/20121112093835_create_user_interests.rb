class CreateUserInterests < ActiveRecord::Migration
  def change
    create_table :user_interests do |t|
      t.integer :user_id
      t.integer :subject_id
    end

    add_index :user_interests, :user_id
    add_index :user_interests, :subject_id
  end
end
