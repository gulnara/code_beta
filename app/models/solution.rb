class Solution < ActiveRecord::Base
	belongs_to :user
	belongs_to :problem
	validates :title, presence: true
	validates :answer, presence: true
end
