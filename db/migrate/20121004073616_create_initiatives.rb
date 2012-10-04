class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.string      :title
      t.belongs_to  :member
      t.text        :description
      t.belongs_to  :subject
      t.string      :summary_by
      t.string      :original_document_url
      t.datetime    :presented_at
      t.integer     :views_count

      t.timestamps
    end

    add_index :initiatives, :member_id
    add_index :initiatives, :subject_id
  end
end
