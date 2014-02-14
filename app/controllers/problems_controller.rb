class ProblemsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :who_are_you, only: [:edit, :update, :destroy]





  def index
    @problems = Problem.order(sort_column + " " + sort_direction)
  end

  def show
  end

  def new
    @problem = current_user.problems.new

  end


  def edit

  end



  def create
    @problem = current_user.problems.build(problem_params)
    @problem.user_id = current_user.id

    if @problem.save
      redirect_to @problem, notice: 'Problem was successfully created.' 
    else
      render action: 'new' 
    end
  end


  def update

    if @problem.update(problem_params)
      redirect_to @problem, notice: 'Problem was successfully updated.' 
    else
      render action: 'edit' 
    end

  end


  def destroy

    @problem.destroy
    redirect_to problems_url 

  end

  private
    
    def set_problem
      @problem = Problem.find(params[:id])
    end

    def sort_column
      Problem.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end


    def who_are_you

      @solutions = Solution.all
      if current_user.try(:admin?)
        @problem = Problem.find(params[:id])

      elsif @problem.user_id == current_user.id 
        if @solutions.first {|s| s.problem_id == @problem.id} != nil 
            redirect_to @problem, notice: 'There are solutions to this problem, you cannot edit or delete this problem.'
        else
          @problem = Problem.find(params[:id])
        end
      else
        redirect_to problems_path, notice: "Not authorized to edit this problem"
      end
    end


 
    def problem_params
      params.require(:problem).permit(:description, :title, :source, :source_title, :user_id)
    end
end
