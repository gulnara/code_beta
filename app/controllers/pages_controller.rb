class PagesController < ApplicationController
  def home
  	# TODO: Probably should limit these queries to a few dozen entries.
  	@problems = Problem.all
  	@solutions = Solution.all
  	@activities = PublicActivity::Activity.all
  end

  def about
  end
end
