namespace :big_years do
  #TODO: generate year subscription for new year and delete subscription for previous year if there isn't any photo of user in BY
  #(this task will do transition from on old year to new year)
  desc 'Generate year subscription for all participant of BigYear for current_year'
  task :gen_subscriptions, [:year] => :environment do |t, args|
    count = 0
    current_year = args.year
    User.where(big_year: true).each do |user|
      count = count + 1 if user.subscribe!(current_year)
    end
    Rails.logger.info("#{Time.zone.now}: Task big_year:gen_subscriptions has generated #{count} subscription for BigYear #{current_year}!")
  end

  desc 'Set big_year flag for all birds of BigYear participants'
  task :set_birds_big_year_for, [:year] => :environment do |t, args|
    update_sql = "
      BEGIN;
      DROP TABLE IF EXISTS tmp_birds;
      CREATE TEMPORARY TABLE tmp_birds AS SELECT b.id as bird_id
                                          FROM birds b
                                            INNER JOIN users u ON b.user_id=u.id AND u.big_year = 'true'
                                          WHERE (EXTRACT(YEAR FROM b.timestamp) = #{args.year}) AND
                                                (EXTRACT(YEAR FROM b.created_at) = #{args.year});
      UPDATE birds SET big_year=#{args.year}
      FROM tmp_birds WHERE birds.id = tmp_birds.bird_id;
      COMMIT;
    "
    Rails.logger.info("#{Time.zone.now}: Task big_year:set_birds_big_year_for sql = #{update_sql}")
    ActiveRecord::Base.connection.execute(update_sql)
    Rails.logger.info("#{Time.zone.now}: Task big_year:set_birds_big_year_for has finished")
  end
end
