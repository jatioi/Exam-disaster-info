class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: :show

  def index
    @comments = @post.comments.page(params[:page]).per(5)

  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'Comment was successful'
    else
      render :new
    end
  end

  def edit
    cookies[:return_to] ||= request.referer
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment updated successfully'
      # redirect_to @post
      redirect_to cookies.delete(:return_to)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = " Comment destroy successfully"
    redirect_to post_comments_path
  end

  private

  def set_post
    @post = Post.find params[:post_id]

  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end


