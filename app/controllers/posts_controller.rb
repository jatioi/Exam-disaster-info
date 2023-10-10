class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def index
    @posts = Post.includes(:categories).all.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new
    end
  end
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comments = @post.comments.includes(:user)
    @comment = @post.comments.build
  end
  def edit; end
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = 'Post update successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post failed to update'
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @post.destroy
    flash[:notice] = "Post destroy successfully"
    redirect_to posts_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :address, category_ids: [])
  end

end
