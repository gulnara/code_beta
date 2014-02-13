class Solution < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :user
	belongs_to :problem
	validates :title, presence: true
	validates :answer, presence: true

end
