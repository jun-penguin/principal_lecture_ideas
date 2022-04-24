20.times do |number|
  User.create!(name: Faker::Name.name,
               email: Faker::Internet.email,
               password: "password#{number + 1}",
               password_confirmation: "password#{number + 1}",
               status: rand(0..4),
               prefecture: rand(0..47),
               )
  Post.create!(title: "校長講話#{number + 1}",
               description: "宇宙の話をしました。",
               content: "校長講話本文",
               status: rand(0..1),
               grade_range: rand(0..1),
               scene_type: rand(0..1),
               user_id: "#{number + 1}",
              )
end

