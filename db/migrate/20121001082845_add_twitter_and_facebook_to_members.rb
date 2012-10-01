class AddTwitterAndFacebookToMembers < ActiveRecord::Migration
  def change
    add_column :members, :twitter, :string
    add_column :members, :facebook, :string
  end
end
