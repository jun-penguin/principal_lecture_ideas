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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:user) { build(:user) }
      it '正常にuserが登録される' do
        expect(user).to be_valid
      end
    end

    context 'ユーザーネームが指定されていないとき' do
      let(:user) { build(:user, name: nil) }
      it 'エラーになる' do
        user.valid?
        expect(user.errors[:name]).to include('が入力されていません。')
      end
    end
  end

  context 'メールアドレスが指定されていないとき' do
    let(:user) { build(:user, email: nil) }
    it 'エラーになる' do
      user.valid?
      expect(user.errors[:email]).to include('が入力されていません。')
    end
  end

  describe '一意性の検証' do
    context 'ユーザーネームが重複したとき' do
      let(:user1) { create(:user) }
      let(:user2) { build(:user, name: user1.name) }
      it 'エラーになる' do
        user2.valid?
        expect(user2.errors[:name]).to include('は既に使用されています。')
      end
    end
    context 'メールアドレスが重複したとき' do
      let(:user1) { create(:user) }
      let(:user2) { build(:user, email: user1.email) }
      it 'エラーになる' do
        user2.valid?
        expect(user2.errors[:email]).to include('は既に使用されています。')
      end
    end
  end
end
