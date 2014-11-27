class Problem < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }

	has_many :solutions
	belongs_to :users
	has_many :users, through: :solutions

	

	has_many :sent_problems
	validates :description, presence: true
	validates :title, presence: true
	validates :source_title, presence: true
	acts_as_taggable
	has_reputation :votes, source: :user , aggregated_by: :sum

	include PgSearch
	pg_search_scope :search, against: [:title, :description],
  	using: {tsearch: {dictionary: "english"}},
  	associated_against: {users: :name, solutions: [:title, :answer]}
	
	def self.text_search(query)
    # where('title @@ :q or description @@ :q', q: query)
    search(query)
  end
	
end
