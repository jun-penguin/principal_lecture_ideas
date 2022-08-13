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
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :description, :content, :status, :grade_range, :scene_type, presence: true
  enum status: { draft: 0, published: 1 }
  enum grade_range: { elementary: 0, junior_high: 1 }
  enum scene_type: { all_school_assembly: 0, event: 1, ceremony: 2, other: 3 }

  def add_search_word(search_word)
    a = half_to_full(search_word)
    b = full_to_half(search_word)
    c = to_kana(search_word)
    d = to_hira(search_word)
    ssp = [a, b, c, d]
  end

  def half_to_full(str)
    str.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
  end

  def full_to_half(str)
    str.tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z')
  end

  def to_kana(str)
    str.tr('ぁ-ん', 'ァ-ン')
  end

  def to_hira(str)
    str.tr('ア-ン', 'あ-ん')
  end

end
