class PagesController < ApplicationController
  def home
  	# TODO: Probably should limit these queries to a few dozen entries.
  	@problems = Problem.all
  	@solutions = Solution.all
  	@activities = PublicActivity::Activity.order("created_at desc")
  end

  def about
  end
end
