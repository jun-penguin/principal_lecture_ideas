# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:like) { build(:like) }
      it '正常にlikeが登録される' do
        expect(like).to be_valid
      end
    end
  end

  describe '一意性の検証' do
    context '同一ユーザーが同一のポストに対し複数のいいねをしたとき' do
      let(:like1) { create(:like) }
      let(:like2) { build(:like, user_id: like1.user_id, post_id: like1.post_id) }
      it 'いいねに失敗する' do
        like2.valid?
        expect(like2.errors[:user_id]).to include('は既に使用されています。')
      end
    end
  end
end
