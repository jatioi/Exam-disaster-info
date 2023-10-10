class WelcomeController < ApplicationController
  def index
    @posts = Post.all.all.order(comments_count: :desc).page(params[:page]).per(5)
  end
end

