class NotesController < ApplicationController

  before_filter :authenticate_user!

  def create
    @note = Note.create!(params[:note].merge(:user => current_user))
    flash[:message] = 'Your note is added, thanks'
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = $!.to_s
  ensure
    redirect_to root_path
  end
end
