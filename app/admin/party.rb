ActiveAdmin.register Party do

  index do
    column :name
    column :short_name
    column :official_id
    default_actions
  end

  form do |f|
    f.inputs "Partido" do
      f.input :name
      f.input :short_name
      f.input :official_id
    end
    f.actions
  end

end


