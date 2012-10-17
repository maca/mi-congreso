class Initiative < ActiveRecord::Base
  attr_accessible :title, :description, :original_document_url, :presented_at, :member_id, :summary_by, :subject_ids, :sponsor_ids, :other_sponsor

  paginates_per 10

  belongs_to :member
  has_and_belongs_to_many :sponsors, class_name: "Member"
  has_and_belongs_to_many :subjects

  validates_presence_of :title, :description, :presented_at

  before_save :calculate_sponsors_count
  after_save :calculate_initiatives_count_for_subjects

  scope :by_subject_id, ->(id) { includes(:subjects).where("subjects.id" => id) }

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
end