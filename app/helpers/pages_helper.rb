module PagesHelper

  def member_column_count(total_count)
    (total_count < 3) ? total_count : 3
  end

  def hide_body_backgroud?
    none_background_pages_options.detect { |options| current_page?(options) }
  end

  def og_image_url
    if controller_name == 'contests' && action_name == 'big_day_in_tashkent'
      URI.join(root_url, image_path('fb/big-day-2015.png'))
    else
      URI.join(root_url, image_path('fb/birds-fb-share.png'))
    end
  end

  def og_title
    if controller_name == 'contests' && action_name == 'big_day_in_tashkent'
      'Большой День в Ташкенте, 15 ноября 2015'
    else
      ''
    end
  end

  def og_description
    if controller_name == 'contests' && action_name == 'big_day_in_tashkent'
      'Любите природу и прогулки по свежему воздуху? Тогда вам наверняка должно понравиться наблюдение за птицами или бердвотчинг. Примите участие в соревновании «Большой День»!'
    else
      'Здесь вы найдете информацию о птицах Узбекистана и много фотографий! Сайт создан людьми, увлеченными птицами и природой, которые готовы помочь каждому в определении птиц.'
    end
  end

  private
  def none_background_pages_options
    [ {controller: 'pages', action: 'index'} ]
  end
end
