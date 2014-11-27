class Problem < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }

	has_many :solutions
	has_many :users, through: :solutions

	belongs_to :users

	has_many :sent_problems
	validates :description, presence: true
	validates :title, presence: true
	validates :source_title, presence: true
	acts_as_taggable
	has_reputation :votes, source: :user , aggregated_by: :sum

	def self.search(search)
    find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
  end
	
end
