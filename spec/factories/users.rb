# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  name                   :string           not null
#  email                  :string           not null
#  status                 :integer          default("not_set"), not null
#  prefecture             :integer          default("未設定"), not null
#  self_introduction      :text
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
  end
end
