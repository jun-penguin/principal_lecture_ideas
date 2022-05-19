100.times do |number|
  User.create!(name: Faker::Name.name,
               email: Faker::Internet.email,
               password: "password#{number + 1}",
               password_confirmation: "password#{number + 1}",
               status: rand(0..4),
               prefecture: rand(0..47))
  Post.create!(title: Faker::Lorem.sentence(word_count: 1),
               description: Faker::Lorem.paragraph(sentence_count: 7),
               content: Faker::Lorem.paragraph(sentence_count: 30),
               status: rand(0..1),
               grade_range: rand(0..1),
               scene_type: rand(0..1),
               user_id: (number + 1).to_s)
end
