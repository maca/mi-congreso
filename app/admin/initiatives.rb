ActiveAdmin.register Initiative do

  index do
    column :title
    column :subjects do |initiative|
      initiative.subjects.map(&:name).join(', ')
    end
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
      f.input :subjects
      f.input :original_document_url
      f.input :presented_at, as: :date_select
      f.input :member_id, as: :select, collection: Member.order(:name)
      f.input :summary_by
    end
    f.actions
  end
end
