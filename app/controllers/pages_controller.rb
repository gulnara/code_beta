class PagesController < ApplicationController
  def home
  	@problems = Problem.all
  	@solutions = Solution.all
  end

  def about
  end
end
