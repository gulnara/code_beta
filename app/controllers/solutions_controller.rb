class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :current_problem


  def index
    @solutions = Solution.all
    id = :problem_id
    @problem =  Problem.find(params[id])
  end


  def show
    @solution = Solution.find(params[:id])
    # problem_id = Solution.find(params[:problem_id])
    # problem_id = Solution.find(params[:problem_id])
    @problem =  Problem.find_by(id: @solution.problem_id )
  end


  def new
    @solution = current_user.solutions.new
    # @problem =  Problem.find_by(id: @solution.problem_id )
    id = :problem_id
    @problem =  Problem.find(params[id]) 
  end


  def edit
    @solution = Solution.find(params[:id])
    # problem_id = Solution.find(params[:problem_id])
    id = @solution.problem_id
    @problem =  Problem.find_by(id: id )
  end


  def create
    id = :problem_id
    @problem =  Problem.find(params[id]) 
    # @problem =  Problem.find_by(id: @solution.problem_id )
    # problem = current_problem
    @solution = current_user.solutions.build(solution_params)
    @solution.problem_id = @problem.id

    if @solution.save
      redirect_to problem_solution_path(@problem, @solution), notice: 'Solution was successfully created.' 
    else
      render action: 'new' 
    end
  end


  def update
    # problem_id = Solution.find(params[:problem_id])

    if @solution.update(solution_params)
      redirect_to problem_solution_path, notice: 'Solution was successfully updated.' 
    else
      render action: 'edit' 
    end

  end


  def destroy
    id = :problem_id
    @problem =  Problem.find(params[id])
    # @problem =  Problem.find_by(id: @solution.problem_id )
    @solution.destroy
    redirect_to problem_solutions_path(@problem) 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:id])
      # @problem =  Problem.find_by(id: @solution.problem_id )
    end

    def correct_user
      @solution = current_user.solutions.find_by(id: params[:id])
      redirect_to solutions_path, notice: "Not authorized to edit this solution" if @solution.nil?
    end

    # def current_problem
    #   problem_id = Solution.find(params[:problem_id])
    #   @problem =  Problem.find_by(id: problem_id ) 

    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:answer, :problem_id, :id )
    end
end
