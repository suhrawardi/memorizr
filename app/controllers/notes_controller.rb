class NotesController < ApplicationController

  before_filter :authenticate_user!

  def create
    @note = Note.create!(note_params(:user => current_user))
    flash[:message] = 'Your note is added, thanks'
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = $!.to_s
  ensure
    redirect_to root_path
  end

private

  def note_params(args)
    params.require(:note).permit(:body, :folder_id).merge(args)
  end
end
