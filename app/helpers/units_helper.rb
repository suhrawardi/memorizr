module UnitsHelper

  def add_tag_js(unit)
    u_id = dom_id(unit, :input_tag)
    u_var = unit.class.name.downcase
    "#{u_var}_#{unit.id}.addTag($('##{u_id}').val());$('##{u_id}').val('');"
  end

  def more_link(unit)
    return raw('&nbsp;') if unit_path(unit) == controller.request.path
    str = link_to 'discuss', unit_path(unit)
    str += " (#{unit.comments.size} comment)" if unit.comments.size == 1
    str += " (#{unit.comments.size} comments)" if unit.comments.size > 1
    str
  end

  def footer(unit)
    "by #{unit.user.name} #{time_ago_in_words(unit.created_at)} ago"
  end
end
