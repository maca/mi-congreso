ActiveAdmin.register Initiative do

  index do
    column :title
    column :member
    column :summary_by
    column :presented_at
    default_actions
  end

  filter :title
  filter :presented_at

  form do |f|
    f.inputs "Iniciativa" do
      f.input :title
      f.input :description
      f.input :original_document_url
      f.input :presented_at, as: :date
      f.input :member_id, as: :select, collection: Member.order(:name)
      f.input :summary_by
    end
    f.buttons
  end
end
