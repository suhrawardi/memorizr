class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @comment = Comment.create!(comment_params(user: current_user))
    flash[:message] = 'Your comment is added, thanks'
    redirect_to unit_path(@comment.unit)
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = $!.to_s
    redirect_to home_index_path
  end

private

  def comment_params(args)
    params.require(:comment).permit(:body, :unit_id).merge(args)
  end
end
