class AddTwitterWidgetIdToMember < ActiveRecord::Migration
  def change
    add_column :members, :twitter_widget_id, :string
  end
end
