class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def recent_posts
    Post.order(created_at: :desc).limit(3)
  end
end
