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
FactoryBot.define do
  factory :post do
    sequence(:title, 'title_1')
    description { '講話紹介' }
    content { '講話内容' }
    status { :published }
    grade_range { :elementary }
    scene_type { :all_school_assembly }
    association :user
  end
end
