class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	solutions
  	# @solution = Solution.find(params[:id])
  	# @problem =  Problem.find_by(id: @solution.problem_id )
  end

  def solutions
  	@solutions = Solution.all
  end
end
