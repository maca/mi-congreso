class AddVotedToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :voted, :boolean, default: false
  end
end
