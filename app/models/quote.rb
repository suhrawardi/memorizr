class Quote < Unit

  before_validation :sanitize_body
  before_validation :absolutize_links

  has_one :web_page

  def self.create_with_page(params)
    page = WebPage.create!(url: params[:url], title: params[:title])
    body = StringHelper.to_utf8(params[:body])
    self.create!(user: params[:user], body: body, web_page: page)
  rescue
    page.destroy if page
    raise $!
  end

  def url
    web_page.try(:url)
  end

  def title
    web_page.try(:title)
  end

  private

  ALLOWED_TAGS = %w(h1 h2 h3 h4 h5 h6 p b em strong i ol ul li img pre abbr a br)
  ALLOWED_ATTR = %w(src href title alt)

  class SanitizeHelper
    include Singleton
    include ActionView::Helpers::SanitizeHelper
  end

  def sanitize_body
    return if self.web_page.nil? or self.body.blank?
    self.body.gsub!(/<!--(.|\s)*?-->/, '') # remove comments as well
    allowed = {tags: ALLOWED_TAGS, attributes: ALLOWED_ATTR}
    unless new_record? # allow highlight tags
      allowed[:tags] += %w(span)
      allowed[:attributes] += %w(class)
    end
    self.body = SanitizeHelper.instance.sanitize(self.body, allowed)
    self.body.strip!
  end

  def absolutize_links
    return if self.web_page.nil? or self.body.blank?
    doc = Nokogiri::HTML.parse(self.body)
    doc.xpath('//a').each do |node|
      link = node.attributes['href'].to_s
      node['href'] = to_abs_link link
      node['rel'] = 'nofollow'
    end
    doc.xpath('//img').each do |node|
      node['src'] = to_abs_link node.attributes['src'].to_s
    end
    self.body = doc.xpath('//body/*').to_xhtml
  end

  def to_abs_link(link)
    return link if link.match(/^(https?:|\/{2})/)
    return "#{self.web_page.root}#{link}" if link.match(/^\//)
    return "#{self.web_page.dirname}/#{link}" unless URI.parse(link).path.blank?
    "#{self.web_page.root}/#{link}"
  end
end
