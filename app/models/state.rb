class State
  include Mongoid::Document

  field :name,        type: String
  field :short_name,  type: String
end
