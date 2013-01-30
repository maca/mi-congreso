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
  filter :district
  filter :region

  form do |f|
    f.inputs "Member" do
      f.input :name
      f.input :alternative_name
      f.input :email
      f.input :comission
      f.input :party_id, as: :select, collection: Party.all
      f.input :state_id, as: :select, collection: State.all
      f.input :election_type, as: :select, collection: [[I18n.t("election_type.relativa"), "relativa"], [I18n.t("election_type.proporcional"), "proporcional"]]
      f.input :district_id, as: :select, collection: f.object.try(:state) ? f.object.state.districts : District.all
      f.input :region_id, as: :select, collection: Region.all
      f.input :birthplace
      f.input :birthdate, as: :date_select, start_year: 1900
      f.input :substitute
      f.input :facebook
      f.input :twitter
      f.input :twitter_widget_id
      f.input :photo
      f.input :education
      f.input :political_experience
      f.input :private_experience
    end
    f.actions
  end
end

