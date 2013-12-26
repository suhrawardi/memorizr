class HomeController < ApplicationController

  def index
    @units = Unit.page(params[:page])
    if current_user
      @note = Note.new
      @attachment = Attachment.new
    end
  end
end
