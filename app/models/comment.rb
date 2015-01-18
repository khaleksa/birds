class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bird

  validates_presence_of :user_id, :bird_id, :text

  scope :bird_comments, ->(bird_id) { Comment.where(bird_id: bird_id).order(created_at: :desc) }

end
