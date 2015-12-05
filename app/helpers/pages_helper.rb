module PagesHelper

  FACEBOOK_PHOTOS = {
      'default' => 'fb/birds-fb-share.png',
      'big_day_in_tashkent' => 'contests/big_year_2015/photo-1.jpg',
      'big_day_photo' => 'fb/big-day-single-2015.png',
      'best_photo' => 'fb/best-photo-fb.png'
  }

  FACEBOOK_DESCRIPTION = {
      'default' => 'Здесь вы найдете информацию о птицах Узбекистана и много фотографий! Сайт создан людьми, увлеченными птицами и природой, которые готовы помочь каждому в определении птиц.',
      'big_day_in_tashkent' => '15ноября в Ташкенте командой Birds.uz проводилось соревнование бердвотчеров-Большой День.',
      'big_day_photo' => 'Индивидуальное соревнование по фотобердингу, в котором может принять участие любой желающий!',
      'best_photo' => 'Мы верим, что фотографирование птиц - лучшая альтернативой охоте на них, что путешествовать по нашей стране интересно, а бердвотчинг познакомит вас с природой и новыми интересными людьми!'
  }

  FACEBOOK_TITLE = {
      'default' => 'Давайте наблюдать птиц вместе!',
      'big_day_in_tashkent' => 'Большой День в Ташкенте или у природы нет плохой погоды',
      'big_day_photo' => 'ФОТО Большой День, Узбекистан, 6 декабря 2015',
      'best_photo' => 'Лучшая фотография птицы Узбекистана'
  }

  def member_column_count(total_count)
    (total_count < 3) ? total_count : 3
  end

  def hide_body_backgroud?
    none_background_pages_options.detect { |options| current_page?(options) }
  end

  def og_image_url
    if controller_name == 'contests' && FACEBOOK_PHOTOS.keys.include?(action_name)
      URI.join(root_url, image_path(FACEBOOK_PHOTOS[action_name]))
    else
      URI.join(root_url, image_path(FACEBOOK_PHOTOS['default']))
    end
  end

  def og_title
    if controller_name == 'contests' && FACEBOOK_PHOTOS.keys.include?(action_name)
      FACEBOOK_TITLE[action_name]
    else
      FACEBOOK_TITLE['default']
    end
  end

  def og_description
    if controller_name == 'contests' && FACEBOOK_PHOTOS.keys.include?(action_name)
      FACEBOOK_DESCRIPTION[action_name]
    else
      FACEBOOK_DESCRIPTION['default']
    end
  end

  def nav_bar_slogan
    if current_user.email == 'marigmaforever@yahoo.com' && Date.parse('5-12-2015') == Date.today
      'Маша, с Днем Рожденья! Birds.uz :)'
    else
      'Birds.uz – давайте наблюдать птиц Узбекистана вместе!'
    end
  end

  private
  def none_background_pages_options
    [ {controller: 'pages', action: 'index'} ]
  end
end
