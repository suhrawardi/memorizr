class AttachmentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @attachment = Attachment.create!(attachment_params(user: current_user))
    flash[:message] = 'Your attachment is added, thanks'
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = $!.to_s
  ensure
    redirect_to root_path
  end

private

  def attachment_params(args)
    params.require(:attachment).permit(:attachment, :folder_id).merge(args)
  end
end
