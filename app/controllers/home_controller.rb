class HomeController < ApplicationController

  def index
    @units = Unit.page(params[:page])
    if current_user
      @note = Note.new(folder: current_user.default_folder)
      @attachment = Attachment.new(folder: current_user.default_folder)
      @ckeditor = true
    end
  end
end
