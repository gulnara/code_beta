class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]
  before_action :are_you_admin_or_creater, only: [:edit, :update, :destroy]
  before_action :authenticate_user!



  def index
    @solutions = Solution.all
    id = :problem_id
    @problem =  Problem.find(params[id])
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
      @solution.create_activity :create, owner: current_user
      redirect_to problem_solution_path(@problem, @solution), notice: 'Solution was successfully created.' 
    else
      render action: 'new' 
    end
  end


  def update
    if @solution.update(solution_params)
      @solution.create_activity :update, owner: current_user
      redirect_to problem_solution_path, notice: 'Solution was successfully updated.' 
    else
      render action: 'edit' 
    end

  end


  def destroy
    id = :problem_id
    @problem =  Problem.find(params[id])
    @solution.destroy
    redirect_to problem_solutions_path(@problem) 
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
