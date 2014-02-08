class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	solutions
  	user_id = @user.id
  	@problem = Problem.all
  	@created_problem = Problem.find_by(user_id: @user.id )
  	# @solution = Solution.find(params[:id])
  	# @problem =  Problem.find_by(id: @solution.problem_id )
  end

  def solutions
  	@solutions = Solution.all
  end


  def send_problem
    UserMailer.email_problems(@user).deliver
  end
end
