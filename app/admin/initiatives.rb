ActiveAdmin.register Initiative do

  index do
    column :gazette_id
    column :title
    column :subjects do |initiative|
      initiative.subjects.map(&:name).join(', ')
    end
    column :member
    column :summary_by
    column :presented_at
    default_actions
  end

  filter :gazette_id
  filter :title
  filter :presented_at

  form do |f|
    f.inputs "Iniciativa" do
      f.input :gazette_id
      f.input :title
      f.input :description
      f.input :subjects
      f.input :original_document_url
      f.input :presented_at, as: :date_select
      f.input :member_id, as: :select, collection: Member.order(:name)
      f.input :sponsors
      f.input :other_sponsor
      f.input :summary_by
      f.input :votes_url
    end
    f.actions
  end

  show do |initiative|
    attributes_table do
      row :gazette_id
      row :title
      row :description
      row :subjects
      row :member
      row :presented_at
      row :summary_by
      row :views_count
      row :original_document_url
      row :votes_url
    end

    render "generate_votes_form"

    active_admin_comments
  end

  member_action :generate_votes, :method => :put do
    initiative = Initiative.find(params[:id])
    session = Session.find(params[:session_id])

    if initiative && session
      votes_created, members_not_found = initiative.generate_votes!(session)
      if members_not_found.any?
        flash_message = {alert: I18n.t("initiatives.members_not_found", not_found: members_not_found.join(", "), votes_created: votes_created)}
      else
        flash_message = {notice: I18n.t("initiatives.votes_generated", votes_created: votes_created)}
      end
    else
      flash_message = {alert: I18n.t("initiatives.initiative_or_session_not_found")}
    end

    redirect_to admin_initiative_path(initiative), flash_message
  end
end
