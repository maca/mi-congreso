class AddVotesUrlToInitiative < ActiveRecord::Migration
  def change
    add_column :initiatives, :votes_url, :string
  end
end
