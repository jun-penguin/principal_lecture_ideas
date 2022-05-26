class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }
  scope :filter_by_post, ->(post_id) { where(post_id:) if post_id }
end
