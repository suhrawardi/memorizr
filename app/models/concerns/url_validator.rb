class UrlValidator < ActiveModel::EachValidator
  require 'uri/http'

  def validate_each(record, attribute, value)
    return if value.nil?
    allowed_schemes = %w(http https).map(&:to_s)
    begin
      uri = URI.parse(value)
      if not allowed_schemes.include?(uri.scheme)
        raise(URI::InvalidURIError)
      end
      if [:scheme, :host].any? { |i| uri.send(i).blank? }
        raise(URI::InvalidURIError)
      end
    rescue URI::InvalidURIError
      record.errors[attribute] << "The provided url is invalid"
    end
  end
end
