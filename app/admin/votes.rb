ActiveAdmin.register Vote do

  index do
    column :value
    column :voter
    column :initiative
    column :session
    default_actions
  end
end
