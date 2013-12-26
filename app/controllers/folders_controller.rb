class FoldersController < ApplicationController

  before_filter :authenticate_user!

  def show
    @folder = Folder.find(params[:id])
    @note = Note.new(folder: @folder)
    @attachment = Attachment.new(folder: @folder)
  end
end
