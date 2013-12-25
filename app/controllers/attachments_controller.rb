class AttachmentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @attachment = Attachment.create!(params[:attachment].merge(user: current_user))
    flash[:message] = 'Your attachment is added, thanks'
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = $!.to_s
  ensure
    redirect_to root_path
  end
end
