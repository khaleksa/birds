module Statistics
  class Counts

    class << self

      # Total amount of species met by all users
      def total_users_species_amount
        Species.joins(:birds)
            .where("(birds.published = 'true') AND (birds.expert_id IS NOT NULL)")
            .select(:id).distinct.count
      end


      # List of all users and the number of their photos(publisheds)
      def users_birds
        sql = "SELECT u.*, COALESCE(ub.birds_count, 0) birds_count
               FROM users u
               LEFT JOIN (
                   SELECT
                      b.user_id,
                      count(b.id) AS birds_count
                   FROM birds b
                   WHERE b.published = 'true'
                   GROUP BY b.user_id
                   ) ub on ub.user_id = u.id
               ORDER BY ub.birds_count DESC NULLS LAST, u.last_name"

        User.find_by_sql(sql)
      end

      # Total amount of species met by some user
      def user_species(user_id)
        list = Species.joins(:birds)
            .with_translations([I18n.locale])
            .where(birds: {published: true, user_id: user_id})
            .where("birds.expert_id IS NOT NULL")
            .distinct
        list.sort_by { |s| s.name } #TODO:: user sql order
      end
    end

  end
end
