class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :post, foreign_key: 'post_id'

  after_create :increment_comments_counter

  private

  def increment_comments_counter
    post.increment!(:comments_counter)
  end
end
