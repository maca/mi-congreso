ActiveAdmin.register Commission do

  index do
    column :name
    column :chamber do |commission|
      t("commissions.chambers.#{commission.chamber}")
    end
    column :president
    default_actions
  end

  form do |f|
    f.inputs "Comision" do
      f.input :name
      f.input :chamber, as: :select, collection: Hash[Commission::VALID_CHAMBERS.map {|c| [I18n.t("commissions.chambers.#{c}"), c]}]
      f.input :president_id, as: :select, collection: Deputy.order("name ASC")
      f.input :secretary_ids, as: :select, input_html: {multiple: "multiple"}, collection: Deputy.order("name ASC")
      f.input :member_ids, as: :select, input_html: {multiple: "multiple"}, collection: Deputy.order("name ASC")
    end
    f.actions
  end
end
