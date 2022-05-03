FactoryBot.define do
  factory :post do
    title { 'MyString' }
    description { 'MyText' }
    content { 'MyText' }
    status { 1 }
    grade_range { 1 }
    scene_type { 1 }
  end
end
