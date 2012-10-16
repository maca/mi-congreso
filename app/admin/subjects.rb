ActiveAdmin.register Subject do

  index do
    column :name
    column :initiatives_count
    default_actions
  end
end
