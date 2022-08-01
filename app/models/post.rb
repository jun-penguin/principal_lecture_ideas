# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  content     :text
#  status      :integer
#  grade_range :integer
#  scene_type  :integer
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :description, :content, :status, :grade_range, :scene_type, presence: true
  enum status: { draft: 0, published: 1 }
  enum grade_range: { elementary: 0, junior_high: 1 }
  enum scene_type: { all_school_assembly: 0, event: 1, ceremony: 2, other: 3 }
end
