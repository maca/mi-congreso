class Initiative < ActiveRecord::Base
  attr_accessible :title, :description, :original_document_url, :presented_at
  attr_accessible :deputy_id, :summary_by, :subject_ids, :sponsor_ids, :other_sponsor
  attr_accessible :votes_url, :gazette_id, :steps_attributes

  paginates_per 10

  belongs_to :deputy
  has_many :votes
  has_many :deputy_votes, class_name: "Vote", conditions: "voter_type = 'Deputy'"
  has_many :user_votes, class_name: "Vote", conditions: "voter_type = 'User'"
  has_and_belongs_to_many :sponsors, class_name: "Deputy"
  has_and_belongs_to_many :subjects
  has_many :steps, class_name: "InitiativeStep", dependent: :destroy, order: "step"

  validates_presence_of :title, :description, :presented_at

  before_save :calculate_sponsors_count
  after_save :populate_voted_field
  after_save :calculate_initiatives_count_for_subjects

  scope :by_subject_id, ->(id) { includes(:subjects).where("subjects.id" => id) }
  scope :latest, ->(int=5) { order("presented_at DESC").limit(int) }
  scope :with_votes, -> { where(voted: true) }

  accepts_nested_attributes_for :steps

  def self.search_with_options(query={}, options={})
    options[:order] ||= "created_at_desc"

    search = self.search(query)
    initiatives = search.result
    initiatives = initiatives.includes(:subjects, :deputy => :party)
    initiatives = initiatives.page(options[:page])
    initiatives = initiatives.sort_order("initiatives.#{options[:order]}")
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
    deputies_not_found = []
    votes_created = 0
    [:for, :against, :neutral, :absent].each do |voter_type|
      scraper = Scraper::Votes.new(self.votes_url, voter_type)
      scraper.deputy_names.each do |deputy_name|
        deputies = Deputy.where{(name =~ deputy_name) | (alternative_name =~ deputy_name)}

        if deputies.any?
          vote = Vote.create(voter: deputies.first, value: voter_type, initiative: self, session: session)
          votes_created += 1 if vote.id
        else
          deputies_not_found << deputy_name
        end
      end
    end

    [votes_created, deputies_not_found]
  end

  def has_been_voted?
    self.deputy_votes.count > 0
  end

  def populate_voted_field
    voted_value = self.has_been_voted?
    self.update_column(:voted, voted_value) if voted_value && voted_value != self.voted
  end

  def percentage_votes(vote_type)
    self.total_votes(vote_type).to_f / Deputy::SEATS.to_f
  end

  def total_votes(vote_type)
    self.deputy_votes.where(value: VoteValue.to_i(vote_type)).count
  end

  def create_user_vote(user, vote_value)
    self.votes.create(voter: user, value: VoteValue.to_i(vote_value))
  end

  def vote_for(person)
    if person.is_a?(User)
      self.user_votes.where(voter_id: person.id).first
    elsif person.is_a?(Deputy)
      self.deputy_votes.where(voter_id: person.id).first
    end
  end

  def total_user_votes_count
    @total_user_votes_count ||= self.user_votes.count
  end

  def user_votes_count(vote_type)
    self.user_votes.where(value: VoteValue.to_i(vote_type)).count
  end

  def users_support_percentage
    return 0 unless total_user_votes_count > 0
    user_votes_count("for").to_f / total_user_votes_count.to_f
  end
end