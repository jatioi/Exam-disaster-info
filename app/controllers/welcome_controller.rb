class WelcomeController < ApplicationController
  def index
    # @posts = Post.includes(:user).order(comments_count: :desc).page(params[:page]).per(5)
    @posts = Post.includes(:categories).all.order(comments_count: :desc).page(params[:page]).per(5)
  end

end


