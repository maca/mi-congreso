class AddInitiativesCountToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :initiatives_count, :integer, default: 0
  end
end
