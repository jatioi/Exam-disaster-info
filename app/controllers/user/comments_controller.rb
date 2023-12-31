class User::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_comments = current_user.comments.page(params[:page])&.per(10)
  end
end
