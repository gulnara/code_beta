class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /solutions
  # GET /solutions.json
  def index
    @solutions = Solution.all
  end

  # GET /solutions/1
  # GET /solutions/1.json
  def show
  end

  # GET /solutions/new
  def new
    @solution = current_user.solutions.build
  end

  # GET /solutions/1/edit
  def edit
  end

  # POST /solutions
  # POST /solutions.json
  def create
    @solution = current_user.solutions.build(solution_params)

    if @solution.save
      redirect_to @solution, notice: 'Solution was successfully created.' 
    else
      render action: 'new' 
    end
  end

  # PATCH/PUT /solutions/1
  # PATCH/PUT /solutions/1.json
  def update

    if @solution.update(solution_params)
      redirect_to @solution, notice: 'Solution was successfully updated.' 
    else
      render action: 'edit' 
    end

  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution.destroy
    redirect_to solutions_url 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:id])
    end

    def correct_user
      @solution = current_user.solutions.find_by(id: params[:id])
      redirect_to solutions_path, notice: "Not authorized to edit this solution" if @solution.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:answer)
    end
end
