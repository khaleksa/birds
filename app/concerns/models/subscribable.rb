module Models
  module Subscribable
    extend ActiveSupport::Concern

    included do
      has_many :subscriptions
    end

    def subscribed?(year)
      subscriptions.where(year: year).any?
    end

    def subscribe!(year)
      subscription = Subscription.where(user_id: self.id, year: year).first
      return if subscription.present?
      Subscription.create(user: self, year: year)
    end

    def unsubscribe!(year)
      subscription = Subscription.where(user_id: self.id, year: year).first
      return unless subscription.present?
      Subscription.destroy(subscription.id)
    end

  end
end
