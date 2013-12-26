class Attachment < Unit

  def image?
    %w(.jpg .jpeg .png .gif).include?(File.extname(attachment.url.to_s))
  end

  def filename
    File.basename(attachment.url.to_s)
  end

end

