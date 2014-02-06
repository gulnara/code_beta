class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :are_you_admin_or_creater, only: [:edit, :update, :destroy]



  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
  end

  # GET /problems/1
  # GET /problems/1.json
  def show

  end

  # GET /problems/new
  # def new
  #   if current_user.try(:admin?) 
  #     @problem = Problem.new
  #   else
  #     redirect_to problems_path, notice: "Not authorized to create a problem"
  #   end
  # end

  def new
    @problem = current_user.problems.new
    # @problem =  Problem.find_by(id: @solution.problem_id )
    # id = :problem_id
    # @problem =  Problem.find(params[id]) 
  end

  # GET /problems/1/edit
  def edit

  end

  # POST /problems
  # POST /problems.json
  # def create
  #   if current_user.try(:admin?) 
  #     @problem = Problem.new(problem_params)
  #     if @problem.save
  #       redirect_to @problem, notice: 'Problem was successfully created.' 
  #     else
  #       render action: 'new' 
  #     end
  #   else
  #     redirect_to problems_path, notice: "Not authorized to create a problem"
  #   end
  # end

  def create
    @problem = current_user.problems.build(problem_params)
    @problem.user_id = current_user.id

    if @problem.save
      redirect_to @problem, notice: 'Problem was successfully created.' 
    else
      render action: 'new' 
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update

    if @problem.update(problem_params)
      redirect_to @problem, notice: 'Problem was successfully updated.' 
    else
      render action: 'edit' 
    end

  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    redirect_to problems_url 

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    def are_you_admin_or_creater
      if current_user.try(:admin?) or @problem.user_id == current_user.id
        @problem = Problem.find(params[:id])
      else
        redirect_to problems_path, notice: "Not authorized to edit this problem"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:description, :title, :source, :user_id)
    end
end
