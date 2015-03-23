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

  #TODO: add method to cut text without word breaking
  def short_comment_text(comment, max_size)
    if comment.text.size > max_size
      return comment.text.to_s.slice(0, max_size)
    else
      return comment.text
    end
  end

  def author_comment_text(comment, max_size)
    author_size = comment.user.full_name.size
    text_size = max_size - author_size
    text = text_size > 0 ? ": #{short_comment_text(comment, text_size)}" : ''
    author = author_size > max_size ? "#{comment.user.full_name.slice(0, max_size)}" : comment.user.full_name
    "#{author}#{text}"
  end
end
