class Member < ActiveRecord::Base
  attr_accessible :birthdate, :birthplace, :comission, :education, :election_type, :email, :name, :alternative_name
  attr_accessible :party_id, :political_experience, :private_experience, :state_id, :substitute, :photo
  attr_accessible :twitter, :twitter_widget_id, :facebook

  belongs_to :state
  belongs_to :party
  belongs_to :district
  belongs_to :region

  has_many :initiatives
  has_many :votes, as: :voter
  has_and_belongs_to_many :co_sponsored_initiatives, class_name: "Initiative"
  has_many :assistances

  SEATS = 500

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

  def assistance_stats
    @assistance_stats ||= MemberAssistanceStats.new(self)
  end

  def self.search_with_party_and_state(query)
    self.includes(:party, :state).order("members.name ASC").search(query)
  end

  def self.find_by_name(member_name)
    self.where{(name =~ member_name) | (alternative_name =~ member_name)}.first
  end

  def self.find_by_section(number, state_id)
    section = Section.joins(:district).where("districts.state_id" => state_id, "sections.number" => number).first
    section.try(:district).try(:member)
  end

  def self.import_districts
    scraper = Scraper::Districts.new
    scraper.members.each do |member_district|
      member = self.find_by_name(member_district.name)
      state = State.find_by_name(member_district.state_name)

      if member && state
        if member_district.district_number
          district = District.where(state_id: state.id, number: member_district.district_number).first
          if district
            member.district = district
            member.save
          else
            puts "District number: #{member_district.district_number}, state: #{state.name} not found"
          end
        elsif member_district.region_number
          region = Region.where(number: member_district.region_number).first
          if region
            member.region = region
            member.save
          else
            puts "Region number: #{member_district.region_number} not found"
          end
        end
      else
        puts "Member ID #{member.try(:id)}, State ID: #{state.try(:id)} not found"
        puts "Name: #{member_district.name}, State Name: #{member_district.state_name}"
      end
    end
  end
end
