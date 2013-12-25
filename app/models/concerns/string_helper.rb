module StringHelper

  def self.to_utf8(str)
    str = str.force_encoding("UTF-8")
    return str if str.valid_encoding?
    str = str.unpack("C*").pack("U*")
    return str if str.valid_encoding?
    str = str.force_encoding("BINARY")
    str.encode("UTF-8", invalid: :replace, undef: :replace)
  end
end
