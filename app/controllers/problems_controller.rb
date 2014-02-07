class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :are_you_admin_or_creater, only: [:edit, :update, :destroy]



  def index
    @problems = Problem.all
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

    def are_you_admin_or_creater
      if current_user.try(:admin?) or @problem.user_id == current_user.id
        @problem = Problem.find(params[:id])
      else
        redirect_to problems_path, notice: "Not authorized to edit this problem"
      end
    end

 
    def problem_params
      params.require(:problem).permit(:description, :title, :source, :user_id)
    end
end
