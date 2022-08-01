# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  user_id    :bigint           not null
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
  scope :filter_by_post, ->(post_id) { where(post_id:) if post_id }
end
