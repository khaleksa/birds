class Stats::Counts
  #TODO: write tests for all methods!!!

  #TODO: try to get off limit & offset
  #TODO: get users with 0 species too
  def big_year_users(year = Time.zone.now.year, limit = nil, offset = nil)
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
                     (EXTRACT(year FROM b.timestamp) = 2015)
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

  def big_year_users_count
    User.where(big_year: true).size
  end

  def big_year_species(year = Time.zone.now.year)
    Species.joins(birds: :user)
      .where(birds: { :published => 'true' })
      .where(users: { :big_year => 'true' })
      .where('EXTRACT(year FROM birds.timestamp) = ?', year)
      .distinct('species.id')
      .order('species.name_ru')
  end

end
