namespace :big_years do
  desc 'Generate year subscription for all participant of BigYear for current_year'
  task gen_subscriptions: :environment do
    count = 0
    current_year = Time.zone.now.year
    User.where(big_year: true).each do |user|
      count = count + 1 if user.subscribe!(current_year)
    end
    Rails.logger.info("#{Time.zone.now}: Task big_year:generate_subscriptions has generated #{count} subscription for BigYear #{current_year}!")
  end
end
