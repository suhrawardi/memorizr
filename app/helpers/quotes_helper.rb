module QuotesHelper

  def show_oembed(url)
    max_size = {:maxwidth => 480, :maxheight => 385}
    resource = OEmbed::Providers.get(url, max_size)
    raw resource.html
  rescue # OEmbed::NotFound (tmp we rescue any errors!)
    '' # We only show OEmbeds
  end
end
