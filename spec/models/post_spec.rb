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
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:post) { build(:post) }
      it '正常にpostが登録される' do
        expect(post).to be_valid
      end
    end

    context 'タイトルが指定されていないとき' do
      let(:post) { build(:post, title: nil) }
      it 'エラーになる' do
        post.valid?
        expect(post.errors[:title]).to include('が入力されていません。')
      end
    end

    context '講話紹介が入力されていないとき' do
      let(:post) { build(:post, description: nil) }
      it 'エラーになる' do
        post.valid?
        expect(post.errors[:description]).to include('が入力されていません。')
      end
    end

    context '本文が入力されていないとき' do
      let(:post) { build(:post, content: nil) }
      it 'エラーになる' do
        post.valid?
        expect(post.errors[:content]).to include('が入力されていません。')
      end
    end
    context 'ステータスが指定されていないとき' do
      let(:post) { build(:post, status: nil) }
      it 'エラーになる' do
        post.valid?
        expect(post.errors[:status]).to include('が入力されていません。')
      end
    end
    context '対象学年が指定されていないとき' do
      let(:post) { build(:post, grade_range: nil) }
      it 'エラーになる' do
        post.valid?
        expect(post.errors[:grade_range]).to include('が入力されていません。')
      end
    end
    context 'シーンタイプが指定されていないとき' do
      let(:post) { build(:post, scene_type: nil) }
      it 'エラーになる' do
        post.valid?
        expect(post.errors[:scene_type]).to include('が入力されていません。')
      end
    end
  end
end
