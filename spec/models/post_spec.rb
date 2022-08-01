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
require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
