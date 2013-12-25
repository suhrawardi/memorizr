module ApplicationHelper

  def show_flash
    flash.inject('') do |str, (key, value)|
      to_flash_msg(key, value)
    end
  end

  def to_flash_msg(cls, msg)
    "<div class=\"alert alert-info #{cls}\">#{msg}</div>"
  end

  def show_js_msg(cls, msg)
    "showJsMsg('#{cls}', '#{escape_javascript(msg)}');"
  end
end
