ActiveAdmin.register Initiative do

  index do
    column :gazette_id
    column :title
    column :subjects do |initiative|
      initiative.subjects.map(&:name).join(', ')
    end
    column :deputy
    column :summary_by
    column :presented_at
    default_actions
  end

  filter :gazette_id
  filter :title
  filter :presented_at
  filter :draft

  form :partial => "form"

  controller do
    def new
      @initiative = Initiative.new
      (1..4).each {|step| @initiative.steps.build(step: step) }
      new!
    end

    def edit
      @initiative = Initiative.find(params[:id])
      (1..4).each {|step| @initiative.steps.build(step: step) } if @initiative.steps.empty?
      edit!
    end
  end

  show do |initiative|
    attributes_table do
      row :gazette_id
      row :title
      row :description
      row :subjects
      row :deputy
      row :presented_at
      row :summary_by
      row :views_count
      row :original_document_url
      row :votes_url
    end

    panel "Pasos" do
      table do
        tr do
          th "Paso"
          th "Inicio"
          th "Camara"
          th "Comisiones"
        end

        initiative.steps.each do |step|
          tr do
            td step.step
            td I18n.l step.start
            td I18n.t("commissions.chambers.#{step.chamber}")
            td step.commissions.map(&:name).join(", ")
          end
        end
      end
    end

    render "generate_votes_form"

    active_admin_comments
  end

  member_action :generate_votes, :method => :put do
    initiative = Initiative.find(params[:id])
    session = Session.find(params[:session_id])

    if initiative && session
      votes_created, deputies_not_found = initiative.generate_votes!(session)
      if deputies_not_found.any?
        flash_message = {alert: I18n.t("initiatives.deputies_not_found", not_found: deputies_not_found.join(", "), votes_created: votes_created)}
      else
        flash_message = {notice: I18n.t("initiatives.votes_generated", votes_created: votes_created)}
      end
    else
      flash_message = {alert: I18n.t("initiatives.initiative_or_session_not_found")}
    end

    redirect_to admin_initiative_path(initiative), flash_message
  end
end
