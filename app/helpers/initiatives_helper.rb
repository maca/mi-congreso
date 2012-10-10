module InitiativesHelper

  def subjects(initiative)
    initiative.subjects.map(&:name).join(", ")
  end
end
