class SetViewsCountDefault < ActiveRecord::Migration
  def up
    change_column_default(:initiatives, :views_count, 0)
  end

  def down
    change_column_default(:initiatives, :views_count, 0)
  end
end
