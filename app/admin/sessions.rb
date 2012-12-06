ActiveAdmin.register Session do

  show do |session|
    attributes_table do
      row :number
      row :date
    end

    render "generate_assistances_form"

    active_admin_comments
  end

  member_action :generate_assistances, method: :put do
    session = Session.find(params[:id])

    if session
      session.generate_assistances!
    end

    redirect_to admin_session_path(session), {notice: I18n.t("sessions.assistances_generated", count: session.assistances.count) }
  end
end
