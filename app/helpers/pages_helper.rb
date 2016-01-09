module PagesHelper

  FACEBOOK_PHOTOS = {
      'default' => 'fb/birds-fb-share.png',
      'big_day_in_tashkent' => 'contests/big_year_2015/bd_tash/photo-1.jpg',
      'big_day_photo' => 'contests/big_year_2015/bd_photo/photo_1.jpg',
      'best_photo' => 'fb/best-photo-fb.png',
      'our_friend' => 'fb/fb-best-friend.png'
  }

  FACEBOOK_DESCRIPTION = {
      'default' => 'Здесь вы найдете информацию о птицах Узбекистана и много фотографий! Сайт создан людьми, увлеченными птицами и природой, которые готовы помочь каждому в определении птиц.',
      'big_day_in_tashkent' => '15ноября в Ташкенте командой Birds.uz проводилось соревнование бердвотчеров-Большой День.',
      'big_day_photo' => 'Участниками соревнования было отмечено 68 видов, среди которых стоит отметить такие редкие виды, как орлан-белохвост, скопа, черноголовый хохотун, белый  аист и черный гриф.',
      'best_photo' => 'Мы верим, что фотографирование птиц - лучшая альтернативой охоте на них, что путешествовать по нашей стране интересно, а бердвотчинг познакомит вас с природой и новыми интересными людьми!',
      'our_friend' => 'Этот человек - самый добрый любитель птиц Узбекистана. Лучшим другом нашего сайта стал Асиф Хан!!! Спасибо тебе, Асиф! '
  }

  FACEBOOK_TITLE = {
      'default' => 'Давайте наблюдать птиц вместе!',
      'big_day_in_tashkent' => 'Большой День в Ташкенте или у природы нет плохой погоды',
      'big_day_photo' => 'ФОТО Большой День, Узбекистан, 6 декабря 2015',
      'best_photo' => 'Лучшая фотография птицы Узбекистана',
      'our_friend' => 'Кто же стал лучшим другом сайта Birds.uz?'
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
    if current_user.try(:birthday).try(:yday) == Date.today.yday
      "#{current_user.first_name}, с Днем Рожденья! Birds.uz :)"
    elsif ['30.12.2015'.to_date, '31.12.2015'.to_date, '1.01.2016'.to_date].include?(Time.current.to_date) && controller_name == 'pages' && action_name == 'index'
      'С Новым Годом! С любовью, команда Birds.uz'
    else
      'Birds.uz – давайте наблюдать птиц Узбекистана вместе!'
    end
  end

  private
  def none_background_pages_options
    [ {controller: 'pages', action: 'index'} ]
  end
end
