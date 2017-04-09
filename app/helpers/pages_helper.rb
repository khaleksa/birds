module PagesHelper

  FACEBOOK_PHOTOS = {
      'default' => 'fb/birds-fb-share.png',
      'big_day_in_tashkent' => 'contests/big_year_2015/bd_tash/photo-1.jpg',
      'big_day_photo' => 'contests/big_year_2015/bd_photo/photo_1.jpg',
      'best_photo' => 'fb/best-photo-fb.png',
      'our_friend' => 'fb/fb-best-friend.png',
      'big_year_result' => 'fb/fb-2015-awards.png',
      'shorebird_day' => 'fb/shorebird-day-2016.jpg'
  }

  FACEBOOK_DESCRIPTION = {
      'default' => 'Здесь вы найдете информацию о птицах Узбекистана и много фотографий! Сайт создан людьми, увлеченными птицами и природой, которые готовы помочь каждому в определении птиц.',
      'big_day_in_tashkent' => '15ноября в Ташкенте командой Birds.uz проводилось соревнование бердвотчеров-Большой День.',
      'big_day_photo' => 'Участниками соревнования было отмечено 68 видов, среди которых стоит отметить такие редкие виды, как орлан-белохвост, скопа, черноголовый хохотун, белый  аист и черный гриф.',
      'best_photo' => 'Мы верим, что фотографирование птиц - лучшая альтернативой охоте на них, что путешествовать по нашей стране интересно, а бердвотчинг познакомит вас с природой и новыми интересными людьми!',
      'our_friend' => 'Этот человек - самый добрый любитель птиц Узбекистана. Лучшим другом нашего сайта стал Асиф Хан!!! Спасибо тебе, Асиф! ',
      'big_year_result' => 'Результаты Большого года 2015: 298 видов птиц, более 3000 регистраций. Победитель этого соревнования среди бердвотчеров зафиксировал 237 видов!',
      'shorebird_day' => 'Приближается 3-й Международный День куликов. В течение этой недели бердвотчеры будут считать куликов по всему миру.'
  }

  FACEBOOK_TITLE = {
      'default' => 'Давайте наблюдать птиц вместе!',
      'big_day_in_tashkent' => 'Большой День в Ташкенте или у природы нет плохой погоды',
      'big_day_photo' => 'ФОТО Большой День, Узбекистан, 6 декабря 2015',
      'best_photo' => 'Лучшая фотография птицы Узбекистана',
      'our_friend' => 'Кто же стал лучшим другом сайта Birds.uz?',
      'big_year_result' => 'Результаты Большого Года 2015!',
      'shorebird_day' => 'Международный день куликов.'
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
    elsif (Time.current.month == 12 && (30..31).include?(Time.current.day)) &&
        (Time.current.month == 1 && (1..2).include?(Time.current.day))
        controller_name == 'pages' &&
        action_name == 'index'
      'С Новым Годом! С любовью, команда Birds.uz'
    elsif Time.current.month == 4 && (1..5).include?(Time.current.day)
      '1 апреля - День рождения Birds.uz!<br>Благодарим всех за этот увлекательный год и поздравляем вас с Днем Птиц!'
    else
      'Birds.uz – давайте наблюдать птиц Узбекистана вместе!'
    end
  end

  private
  def none_background_pages_options
    [ {controller: 'pages', action: 'index'} ]
  end
end
