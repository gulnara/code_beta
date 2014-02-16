class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
  	@user = User.find(params[:id])
  	solutions
  	user_id = @user.id
  	@problem = Problem.all
  	@created_problem = Problem.find_by(user_id: @user.id )
    @created_problems = Problem.where(user_id: @user.id ).all
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
    @all_friends = @user.friend_ids
  end

  def index

    @users = User.all

  end

  def solutions
  	@solutions = Solution.all
  end

  def destroy
    # QUESTION: What happens if we destroy a user that has already submitted problems?
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        render action: 'index' , notice: "User deleted."
    end
  end




  def self.check_if_problem_was_sent(user,problem)
    # TODO: Might be faster to call the #any? method
    SentProblem.where(:user_id=> user.id).where(:problem_id=>problem.id).first
  end

  def self.check_if_user_solved_problem(user,problem)
    # TODO: Might be faster to call the #any? method
    Solution.where(:user_id=> user.id).where(:problem_id=>problem.id).first
  end

  # Iterates over all users and send 1 problem to each
  def self.send_problems_to_users
    @problems = Problem.all
    users = User.all
    
    users.each do |user|
 
      if  user.subscribed == true
        send_problem(user, @problems)
      end
      
    end
  end
  
  
  # Sends a problem to a specific user
  def self.send_problem(user, problems)
    @problems.shuffle!
    @problems.each do |p|
      unless check_if_problem_was_sent(user, p) or check_if_user_solved_problem(user, p)
        #update sent_problem table
        s = SentProblem.where(:user_id=> user.id).where(:problem_id=>p.id).create
        s.save
        UserMailer.email_problems(user, p).deliver
        return
      end
    end
  end

end
