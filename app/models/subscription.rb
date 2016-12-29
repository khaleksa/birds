class Subscription < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :year

end
