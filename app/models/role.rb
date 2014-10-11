class Role < ActiveRecord::Base
  has_and_belongs_to_many :user

  validates_presence_of :name
end
