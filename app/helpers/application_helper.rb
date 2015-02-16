module ApplicationHelper

  def ldate(dt, hash = {})
    dt ? l(dt, hash) : nil
  end

  def nav_link_to(name = nil, options = nil, html_options = nil, &block)
    is_active = request.path.start_with?(url_for(options)) ? true : false

    li_class = []
    li_class.append(html_options.delete(:li_class)) if html_options
    li_class.append(:active) if is_active

    content_tag :li, class: li_class.presence do
      link_to(name, options, html_options, &block)
    end
  end

  def date_format(date)
    return '' unless date.present?
    date.strftime('%d/%m/%Y')
  end
end
