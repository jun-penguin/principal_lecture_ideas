# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  user_id    :bigint           not null
#  post_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:comment) { build(:comment) }
      it '正常にコメントが登録される' do
        expect(comment).to be_valid
      end
    end
    context 'コメントが入力されていないとき' do
      let(:comment) { build(:comment, body: nil) }
      it 'コメントの登録に失敗する' do
        comment.valid?
        expect(comment.errors[:body]).to include('が入力されていません。')
      end
    end
  end
end
