require "#{Rails.root}/app/models/concerns/url_validator"

class WebPage < ActiveRecord::Base

  belongs_to :note
  belongs_to :user

  delegate :scheme, :host, :port, :path, :query, to: :uri

  validates :url, url: true

  def uri
    @uri ||= UriHelper.new(url)
  end

  def dirname
    File.dirname(url)
  end

  def root
    "#{scheme}://#{host}"
  end
end
