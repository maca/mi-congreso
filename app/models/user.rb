class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :user_interests, dependent: :destroy
  has_many :subjects, through: :user_interests
  belongs_to :section

  validates :name, presence: true

  delegate :district, :to => :section, :allow_nil => true
  delegate :deputy, :to => :district, :allow_nil => true
end