class Solution < ActiveRecord::Base
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
	belongs_to :user
	belongs_to :problem
	validates :title, presence: true
	validates :answer, presence: true

end
