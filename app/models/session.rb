class Session < ActiveRecord::Base
  attr_accessible :date, :number

  has_many  :votes, dependent: :destroy

  def name
    I18n.t("sessions.name", number: self.number)
  end
end
