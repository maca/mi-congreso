class AddOfficialIdToParties < ActiveRecord::Migration
  def change
    add_column :parties, :official_id, :integer
  end
end
