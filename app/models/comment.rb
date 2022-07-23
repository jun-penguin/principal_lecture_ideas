class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
  scope :filter_by_post, ->(post_id) { where(post_id:) if post_id }
end
