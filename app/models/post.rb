# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text             not null
#  content     :text             not null
#  status      :integer          not null
#  grade_range :integer          not null
#  scene_type  :integer          not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Post < ApplicationRecord
  # hash化
  include Hashid::Rails
  belongs_to :user
  has_many :users, through: :likes
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :description, :content, :status, :grade_range, :scene_type, presence: true
  enum status: { draft: 0, published: 1 }
  enum grade_range: { elementary: 0, junior_high: 1 }
  enum scene_type: { all_school_assembly: 0, event: 1, ceremony: 2, other: 3 }
end
