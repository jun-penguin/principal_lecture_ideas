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
require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:admin) { build(:admin) }
      it '正常にadminユーザーが登録される' do
        expect(admin).to be_valid
      end
    end

    context 'メールアドレスが指定されていないとき' do
      let(:admin) { build(:admin, email: nil) }
      it 'adminユーザーの登録に失敗する' do
        admin.valid?
        expect(admin.errors[:email]).to include('が入力されていません。')
      end
    end
    context 'パスワードが指定されていないとき' do
      let(:admin) { build(:admin, password: nil) }
      it 'adminユーザーの登録に失敗する' do
        admin.valid?
        expect(admin.errors[:password]).to include('が入力されていません。')
      end
    end
  end

  describe '一意性の検証' do
    context 'メールアドレスが重複したとき' do
      let(:admin1) { create(:admin) }
      let(:admin2) { build(:admin, email: admin1.email) }
      it 'adminユーザーの登録に失敗する' do
        admin2.valid?
        expect(admin2.errors[:email]).to include('は既に使用されています。')
      end
    end
  end
end
