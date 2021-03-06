class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]
  before_action :are_you_admin_or_creater, only: [:edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :solutions, :show]



  def index
    @solutions = Solution.all
    id = :problem_id
    @problem =  Problem.find(params[id])
  end

  def solutions
    if params[:query]
      @solutions = Solution.text_search(params[:query]).paginate(:page => params[:page], :per_page => 10)
    else
      @solutions = Solution.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @solution = Solution.find(params[:id])
    @problem =  Problem.find_by(id: @solution.problem_id )
  end


  def new
    @solution = current_user.solutions.new
    id = :problem_id
    @problem =  Problem.find(params[id]) 
  end


  def edit
    @solution = Solution.find(params[:id])
    id = @solution.problem_id
    @problem =  Problem.find_by(id: id )
  end


  def create
    id = :problem_id
    @problem =  Problem.find(params[id]) 
    @solution = current_user.solutions.build(solution_params)
    @solution.problem_id = @problem.id

    if @solution.save
      # @solution.create_activity :create, owner: current_user
      current_number = @problem.solutions_number
      new_number = current_number + 1
      @problem.update_column(:solutions_number, new_number)
      redirect_to problem_solution_path(@problem, @solution), notice: 'Solution was successfully created.' 
    else
      render action: 'new' 
    end
  end


  def update
    if @solution.update(solution_params)
      redirect_to problem_solution_path, notice: 'Solution was successfully updated.' 
    else
      render action: 'edit' 
    end

  end


  def destroy
    id = :problem_id
    @problem =  Problem.find(params[id])
    @solution.destroy
    redirect_to problem_path(@problem) 
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @solution = Solution.find(params[:id])
    @solution.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end

  private
   
    def set_solution
      @solution = Solution.find(params[:id])
    end

    def are_you_admin_or_creater
      if current_user.try(:admin?) or @solution.user == current_user
        @solution = Solution.find(params[:id])
        # @solution = current_user.solutions.find_by(id: params[:id])
      else  
        redirect_to solutions_path, notice: "Not authorized to edit this solution" if @solution.nil?
      end
    end

   
    def solution_params
      params.require(:solution).permit(:answer, :problem_id, :id, :language, :title )
    end
end
