class AddAlternativeNameToMember < ActiveRecord::Migration
  def change
    add_column :members, :alternative_name, :string
  end
end
