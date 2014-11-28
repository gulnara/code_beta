class Solution < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
	belongs_to :user
	belongs_to :problem
	validates :title, presence: true
	validates :answer, presence: true

	has_reputation :votes, source: :user, aggregated_by: :sum
	has_many :comments, as: :commentable

	include PgSearch
	pg_search_scope :search, against: [:title, :answer],
  	using: {tsearch: {dictionary: "english"}},
  	associated_against: {user: :name}
	
	def self.text_search(query)
    search(query)
  end

end
