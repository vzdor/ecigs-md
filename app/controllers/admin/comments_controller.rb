class Admin::CommentsController < AdminController
  before_filter :get_comment, :except => [:index]

  def index
    @comments = Comment.recent.page params[:page]
  end

  def update
    @comment.attributes = params[:comment]
    @comment.save!
    flash[:notice] = "Comment updated."
    redirect_to commentable_path(@comment)
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to :back
  end

  protected

  def get_comment
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
  end
end
