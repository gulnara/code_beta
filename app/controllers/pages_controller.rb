class PagesController < ApplicationController
  def home
  	@problems = Problem.all
  	@solutions = Solution.all
  	@activities = PublicActivity::Activity.all
  end

  def about
  end
end
