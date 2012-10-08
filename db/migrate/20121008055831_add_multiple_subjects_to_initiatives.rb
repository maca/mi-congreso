class AddMultipleSubjectsToInitiatives < ActiveRecord::Migration
  def change
    remove_index :initiatives, :subject_id
    remove_column :initiatives, :subject_id

    create_table :initiatives_subjects, id: false do |t|
      t.integer :initiative_id
      t.integer :subject_id
    end

    add_index :initiatives_subjects, :initiative_id
    add_index :initiatives_subjects, :subject_id
  end
end
