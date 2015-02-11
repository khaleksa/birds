class Stats::Counts
  #TODO: write tests for all methods!!!

  #TODO: try to get off limit & offset
  #TODO: get users with 0 species too
  def big_year_users_species_count(year = Time.zone.now.year, limit = nil, offset = nil)
    sql = ActiveRecord::Base.send(:sanitize_sql_array, ["
      SELECT users.first_name, users.last_name, t1.user_id, t1.species_count
      FROM users
      INNER JOIN (
        SELECT
          t.user_id,
          count(t.species_id) species_count
        FROM (
          SELECT
           u.id user_id,
           b.species_id
          FROM users u
           INNER JOIN birds b ON b.user_id = u.id
          WHERE (u.big_year = 'true') AND
               (b.published = 'true') AND
               (EXTRACT(year FROM b.timestamp) = ?)
          GROUP BY u.id, b.species_id
             ) t
        GROUP BY t.user_id
        ) t1 on t1.user_id = users.id
      ORDER BY t1.species_count DESC
      ",
      year
    ])
    sql += " LIMIT #{limit}" if limit
    sql += " OFFSET #{offset}" if offset

    User.connection.select_all(sql)
  end

  def big_year_user_species_count(user_id, year = Time.zone.now.year)
    Bird.where(user_id: user_id).where("EXTRACT(year FROM timestamp) = ?", year).select(:species_id).distinct(:species_id).size
  end

  def big_year_users_count
    User.where(big_year: true).size
  end

  #TODO: add params validation, check when user doesn't have any photo
  def big_year_user_rating(user_id, year = Time.zone.now.year)
    return 0 unless User.find(user_id).big_year # ???
    index = big_year_users_species_count(year).find_index { |user| user['user_id'].to_i == user_id }
    index ? index + 1 : 0
  end

  def big_year_species(year = Time.zone.now.year)
    Species.joins(birds: :user)
      .where(birds: { :published => 'true' })
      .where(users: { :big_year => 'true' })
      .where('EXTRACT(year FROM birds.timestamp) = ?', year)
      .distinct('species.id')
      .order('species.name_ru')
  end

  def birds_species_count
    Species.joins(:birds).where(birds: {published: true}).select(:id).distinct.count
  end
end
