class Initiative < ActiveRecord::Base
  attr_accessible :title, :description, :original_document_url, :presented_at, :member_id, :summary_by, :subject_ids, :sponsor_ids, :other_sponsor, :votes_url

  paginates_per 10

  belongs_to :member
  has_many :member_votes, class_name: "Vote", conditions: "voter_type = 'Member'"
  has_and_belongs_to_many :sponsors, class_name: "Member"
  has_and_belongs_to_many :subjects

  validates_presence_of :title, :description, :presented_at

  before_save :calculate_sponsors_count
  after_save :calculate_initiatives_count_for_subjects

  scope :by_subject_id, ->(id) { includes(:subjects).where("subjects.id" => id) }
  scope :latest, ->(int=5) { order("presented_at DESC").limit(int) }

  def self.search_with_options(query={}, options={})
    search = self.search(query)
    initiatives = search.result
    initiatives = initiatives.includes(:subjects, :member => :party)
    initiatives = initiatives.page(options[:page])
    initiatives = initiatives.sort_order("#{options[:order]}") if options[:order]
    initiatives
  end

  def increase_views_count!
    self.views_count = self.views_count.to_i + 1
    self.save
  end

  def calculate_sponsors_count
    self.sponsors_count = self.sponsors.count
  end

  def calculate_initiatives_count_for_subjects
    self.subjects.each {|s| s.calculate_initiatives_count! }
  end

  def generate_votes!(session)
    members_not_found = []
    votes_created = 0
    [:for, :against, :neutral, :absent].each do |voter_type|
      scraper = Scraper::Votes.new(self.votes_url, voter_type)
      scraper.member_names.each do |member_name|
        members = Member.where{(name =~ member_name) | (alternative_name =~ member_name)}

        if members.any?
          vote = Vote.create(voter: members.first, value: voter_type, initiative: self, session: session)
          votes_created += 1 if vote.id
        else
          members_not_found << member_name
        end
      end
    end

    [votes_created, members_not_found]
  end

  def has_been_voted?
    self.member_votes.count > 0
  end

  def percentage_votes(vote_type)
    self.total_votes(vote_type).to_f / Member::SEATS.to_f
  end

  def total_votes(vote_type)
    self.member_votes.where(value: VoteValue.to_i(vote_type)).count
  end
end