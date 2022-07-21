class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :description, :content, :status, :grade_range, :scene_type, presence: true
  enum status: { draft: 0, published: 1 }
  enum grade_range: { elementary: 0, junior_high: 1 }
  enum scene_type: { all_school_assembly: 0, event: 1, ceremony: 2, other: 3 }
end
