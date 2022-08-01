# == Schema Information
#
# Table name: admins
#
#  id                  :bigint           not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :admin do
    email { 'user@example.com' }
    password { 'password' }
  end
end
