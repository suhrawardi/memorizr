class UsersController < ApplicationController

  before_filter :authenticate_user!

  def units
    @units = Unit.where(user: User.find(params[:id])).page(params[:page])
    @note = Note.new
    @attachment = Attachment.new
  end
end
