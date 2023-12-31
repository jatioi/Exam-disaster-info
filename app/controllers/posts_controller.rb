class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def index
    @posts = current_user&.posts&.order(comments_count: :desc)&.page(params[:page])&.per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to user_posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new
    end
  end
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page])&.per(10)
    @comments = @post.comments.includes(:user)
    @comment = @post.comments.build
    session[:previous_url] = request.referer
  end
  def edit
    @post = Post.find(params[:id])
    @page = params[:page]
    cookies[:return_to] ||= request.referer
  end
  def update
    @post = Post.find(params[:id])
    @page = params[:page]
    if @post.update(post_params)
      flash[:notice] = 'Post update successfully'
      # redirect_to params[:from_my_post].present? ? user_posts_path : root_path(page: @page)
      redirect_to cookies.delete(:return_to)
    else
      flash.now[:alert] = 'Post failed to update'
      render :edit, status: :unprocessable_entity
    end

  end
  def destroy
    @post.destroy
    flash[:notice] = "Post destroy successfully"
    redirect_to user_posts_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content,:address, :image, category_ids: [])
  end

end
