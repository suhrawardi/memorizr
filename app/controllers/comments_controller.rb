class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @comment = Comment.create!(params[:comment].merge(user: current_user))
    flash[:message] = 'Your comment is added, thanks'
    redirect_to unit_path(@comment.unit)
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = $!.to_s
    redirect_to home_index_path
  end
end
