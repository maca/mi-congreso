ActiveAdmin.register User do

  index do
    column :id
    column :name
    column :email
    column :interests do |user|
      user.subjects.map(&:name).join(", ")
    end
    default_actions
  end

  filter :name
  filter :email
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Usuario" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
