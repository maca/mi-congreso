class Party
  include Mongoid::Document

  has_many :members

  field :name,        type: String
  field :short_name,  type: String
end
