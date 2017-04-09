module Statistics
  class BigYear

    class << self

      # Calc species count for every participant of BigYear
      def users_species_count(year = Time.zone.now.year)
        sql = ActiveRecord::Base.send(:sanitize_sql_array, ["
          DROP TABLE IF EXISTS bird_species_tmp;
          CREATE TEMPORARY TABLE bird_species_tmp AS (
            SELECT
              u.id user_id,
              b.species_id
            FROM users u
              INNER JOIN subscriptions s on s.user_id = u.id AND s.year = ?
              INNER JOIN birds b ON (b.user_id = u.id) AND
                                    (b.published = 'true') AND
                                    (b.species_id IS NOT NULL) AND
                                    (b.expert_id IS NOT NULL) AND
                                    (b.big_year = ?)
            GROUP BY u.id, b.species_id
          );
          SELECT u.*, COUNT(bs.species_id) as species_count
          FROM users u
            INNER JOIN bird_species_tmp bs ON bs.user_id = u.id
          GROUP BY u.id
          ORDER BY COUNT(bs.species_id) DESC;
          ",
          year,
          year
        ])
        User.find_by_sql(sql)
      end

      # All species met by participants of Big Year during the year
      def species(year = Time.zone.now.year)
        Species.joins(birds: {user: :subscriptions})
            .where("(birds.published = 'true') AND (birds.species_id IS NOT NULL) AND (birds.expert_id IS NOT NULL) ")
            .where('birds.big_year = ?', year)
            .where('subscriptions.year = ?', year)
            .distinct('species.id')
            .order('species.name_ru')
      end

      # Total amount of all user who has at least one subscription for BigYear
      def users_count
        User.joins(:subscriptions).count
      end

      # The amount of user's species in BigYear for some year
      def user_species_count(user_id, year = Time.zone.now.year)
        return 0 unless (user = User.find(user_id)) && user.subscribed?(year)
        Bird.published.known.approved
            .where(user_id: user_id)
            .where("EXTRACT(year FROM timestamp) = ?", year)
            .where("EXTRACT(year FROM created_at) = ?", year)
            .select(:species_id).distinct(:species_id)
            .size
      end

      # User's place in BigYear rating
      def user_rating(user_id, year = Time.zone.now.year)
        return 0 unless (user = User.find(user_id)) && user.subscribed?(year)
        index = users_species_count(year).find_index { |user| user.id == user_id }
        index ? index + 1 : 0
      end

      # User's amount of downloaded & approved species during BigDay
      def big_day_rating(big_day_timestamp, download_start, download_stop )
        sql = "
          SELECT users.id, users.first_name, users.last_name, sp.species_count, asp.approved_species_count
          FROM users
          INNER JOIN (
              SELECT user_id, count(DISTINCT species_id) AS species_count
              FROM birds
              WHERE (species_id IS NOT NULL) AND (timestamp::DATE = :day) AND (created_at BETWEEN :date_begin AND :date_end )
              GROUP BY user_id
              ) sp ON sp.user_id = users.id
          LEFT JOIN (
              SELECT user_id, count(DISTINCT species_id) AS approved_species_count
              FROM birds
              WHERE (species_id IS NOT NULL) AND (expert_id IS NOT NULL) AND (timestamp::DATE = :day) AND (created_at BETWEEN :date_begin AND :date_end )
              GROUP BY user_id
              ) asp ON asp.user_id = sp.user_id
          ORDER BY sp.species_count DESC
        "
        sanitized_sql = ActiveRecord::Base.send :sanitize_sql_array, [sql,
                                                                      day: big_day_timestamp.strftime('%Y-%m-%d'),
                                                                      date_begin: download_start,
                                                                      date_end: download_stop]
        Bird.find_by_sql(sanitized_sql)
      end

    end

  end
end
