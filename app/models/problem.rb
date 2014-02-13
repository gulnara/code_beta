class Problem < ActiveRecord::Base
	has_many :solutions
	has_many :users, through: :solutions

	belongs_to :users

	has_many :sent_problems
	validates :description, presence: true
	validates :title, presence: true
	validates :source, presence: true
	validates :source_title, presence: true
end
