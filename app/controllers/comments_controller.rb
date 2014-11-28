class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

	def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
      if @comment.destroy
        respond_to do |format|
          format.html { redirect_to @commentable, notice: "Comment deleted."  }
        end
      end
   end

private

  def set_comment
    @problem = Problem.find(params[:id])
  end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  # def comment_params
  #     params.require(:comment).permit(:content)
  # end

  # alternative option:
  # def load_commentable
  #   klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
end