module FoldersHelper

  def sanitize_unit(text)
    tags = %w(h1 h2 h3 h4 h5 h6 p b i ol ul li pre abbr br span em strong)
    attrs = %w(alt title)
    sanitize text, :tags => tags, :attributes => attrs
  end
end
