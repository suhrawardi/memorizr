class UsersController < ApplicationController

  before_filter :authenticate_user!

  def units
    @units = Unit.where(user: User.find(params[:id])).page(params[:page])
    @note = Note.new(folder: current_user.default_folder)
    @attachment = Attachment.new(folder: current_user.default_folder)
    @ckeditor = true
  end
end
