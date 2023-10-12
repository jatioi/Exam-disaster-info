class User::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_posts = current_user.posts.all.page(params[:page])&.per(10)
  end
end
