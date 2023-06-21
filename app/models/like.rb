class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, foreign_key: 'post_id'

  after_create :increment_likes_counter

  def increment_likes_counter
    post.increment!(:likes_counter)
  end
end
