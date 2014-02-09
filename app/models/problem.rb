class Problem < ActiveRecord::Base
	has_many :solutions
	has_many :users, through: :solutions

	belongs_to :users

	has_many :sent_problems
end
