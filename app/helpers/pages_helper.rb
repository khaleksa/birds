module PagesHelper

  def member_column_count(total_count)
    (total_count < 3) ? total_count : 3
  end

  def hide_body_backgroud?
    none_background_pages_options.detect { |options| current_page?(options) }
  end

  private
  def none_background_pages_options
    [ {controller: 'pages', action: 'index'} ]
  end
end
