class Initiative < ActiveRecord::Base
  attr_accessible :description, :member_id, :original_document_url, :presented_at, :subject_id, :title

  belongs_to :member
  belongs_to :subject
end
