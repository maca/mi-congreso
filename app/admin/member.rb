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
      f.input :comission
      f.input :party_id, as: :select, collection: Party.all
      f.input :state_id, as: :select, collection: State.all
      f.input :election_type, as: :select, collection: [[I18n.t("election_type.relativa"), "relativa"], [I18n.t("election_type.proporcional"), "proporcional"]]
      f.input :birthplace
      f.input :birthdate, as: :date, start_year: 1900
      f.input :substitute
      f.input :facebook
      f.input :twitter
      f.input :photo
      f.input :education
      f.input :political_experience
      f.input :private_experience
    end
    f.buttons
  end
end

