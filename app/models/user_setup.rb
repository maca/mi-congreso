class UserSetup

  attr_reader :user, :attributes

  def initialize(user, attributes={})
    @user = user
    @attributes = attributes.try(:symbolize_keys) || {}
  end

  def save
    @user.subject_ids = attributes[:subject_ids]
    @user.receive_notifications = attributes[:receive_notifications]
    @user.save
  end

end