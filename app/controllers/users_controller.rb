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

  def self.randomize(number_of_problems)
   #pick a random number within number_of_problems range
    problem_id = rand(number_of_problems)
    #find a problem with that id 
    problem_to_be_sent = Problem.find_by(id: problem_id )
  end

  def self.user_subscribed(user)
    user.subscribed
  end

  def self.check_if_problem_was_sent(user,problem)
    SentProblem.where(:user_id=> user.id).where(:problem_id=>problem.id).first
  end

  def self.check_if_user_solved_problem(user,problem)
    Solution.where(:user_id=> user.id).where(:problem_id=>problem.id).first
  end

  # Iterates over all users and send 1 problem to each
  def self.send_problems_to_users
    problems = Problem.all
    users = User.all
    
    users.each do |user|
 
      if  user_subscribed(user) == true
        send_problem(user, problems)
      end
      
    end
  end
  
  
  # Sends a problem to a specific user
  def self.send_problem(user, problems)
    
    problems = Problem.all
    number_of_problems = problems.count
    p = randomize(number_of_problems)
    if check_if_problem_was_sent(user, p) != nil and check_if_user_solved_problem(user, p) != nil
      return send_problem(user, problems)
    else
      #update sent_problem table
      s = SentProblem.where(:user_id=> user.id).where(:problem_id=>p.id).create
      s.save
      UserMailer.email_problems(user, p).deliver
    end
  end

end
