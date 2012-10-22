class Member < ActiveRecord::Base
  attr_accessible :birthdate, :birthplace, :comission, :education, :election_type, :email, :name, :alternative_name
  attr_accessible :party_id, :political_experience, :private_experience, :state_id, :substitute, :photo
  attr_accessible :twitter, :facebook

  belongs_to :state
  belongs_to :party

  has_many :initiatives
  has_many :votes, as: :voter
  has_and_belongs_to_many :co_sponsored_initiatives, class_name: "Initiative"

  has_attached_file :photo, :styles => { :thumb => "100x100>" },
                            :storage => :s3,
                            :s3_credentials => {
                              :bucket            => ENV['S3_BUCKET_NAME'],
                              :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
                              :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                            }

  def all_initiatives(limit=5)
    initiatives = self.initiatives + self.co_sponsored_initiatives
    initiatives = initiatives.sort_by {|i| i.presented_at }.reverse
    initiatives[0..limit-1]
  end

  def party_name
    self.party.try(:name)
  end

  def state_name
    self.state.try(:name)
  end

  def age
    ((Date.today - birthdate.to_date)/365).to_i if birthdate
  end

  def self.search_with_party_and_state(query)
    self.includes(:party, :state).search(query)
  end
end
