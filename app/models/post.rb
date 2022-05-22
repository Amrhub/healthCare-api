class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  before_save :intialize_likes_comments_counter

  def recent_posts
    Post.order(created_at: :desc).limit(3)
  end

  def intialize_likes_comments_counter
    self.likes_counter = 0
    self.comments_counter = 0
  end
end
