class Attachment < Unit

  # Setup accessible (or protected) attributes for your model
  attr_accessible :user, :attachment, :folder_id

  def image?
    %w(.jpg .jpeg .png .gif).include?(File.extname(attachment.url.to_s))
  end

  def filename
    File.basename(attachment.url.to_s)
  end

end

