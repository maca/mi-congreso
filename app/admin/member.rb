ActiveAdmin.register Member do
  index do
    column :name
    column :email
    column :party
    column :state
    default_actions
  end

  filter :party
  filter :state
  filter :name

  form do |f|
    f.inputs "Member" do
      f.input :name
      f.input :email
      f.input :party_id, as: :select, collection: Party.all
      f.input :state_id, as: :select, collection: State.all
    end
    f.buttons
  end
end

