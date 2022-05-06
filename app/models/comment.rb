class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :increment_post_comments_counter

  private

  def increment_post_comments_count
    post.increment!(:comments_counter)
  end
end
