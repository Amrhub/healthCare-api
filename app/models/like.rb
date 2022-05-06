class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :increment_post_likes_count
  after_destroy :decrement_post_likes_count

  private

  def increment_post_likes_count
    post.increment!(:likes_counter)
  end

  def decrement_post_likes_count
    post.decrement!(:likes_counter)
  end
end
