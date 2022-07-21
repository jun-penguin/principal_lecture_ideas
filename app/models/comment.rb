class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
end
