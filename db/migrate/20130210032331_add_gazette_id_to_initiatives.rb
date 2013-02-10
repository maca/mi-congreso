class AddGazetteIdToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :gazette_id, :integer
  end
end
