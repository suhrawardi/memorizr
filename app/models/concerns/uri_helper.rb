class UriHelper
  require 'uri/http'

  def initialize(uri)
    @uri = uri
  end

  %w(scheme host port path query).each do |name|
    define_method(name) do
      return nil if uri.nil?
      uri.send(name.to_sym)
    end
  end

  def uri
    @parsed_uri ||= parse_uri
  end

private

  def parse_uri
    URI.parse(@uri)
  rescue URI::InvalidURIError
    nil
  end
end
