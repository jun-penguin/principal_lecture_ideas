require 'rails_helper'

RSpec.describe 'コメントのCRUD機能', type: :system, js: true do
  describe 'ログイン前' do
    let!(:post) { create(:post) }
    let!(:user) { create(:user) }
    let!(:comment) { create(:comment, user:, post:) }
    before { visit("/post/#{post.id}") }
    describe 'コメントの表示' do
      context '講話の詳細ページにアクセス' do
        xit 'コメントが表示されるが、編集・削除・新規作成フォームは表示されない' do
          expect(page).to have_content(comment.body)
          expect(page).to_not have_content('編集')
          expect(page).to_not have_content('削除')
          expect(page).to_not have_content('コメントを書く')
        end
      end
    end
  end
  describe 'ログイン後' do
    let!(:post) { create(:post) }
    let!(:user) { create(:user) }
    let!(:comment) { create(:comment, user:, post:) }
    let!(:other_comment) { create(:comment, post:, body: '他人のコメント') }
    before { login(user) }
    before { visit("/post/#{post.id}") }
    describe 'コメントの表示' do
      context '講話の詳細ページにアクセス' do
        xit 'コメント及び編集、削除ボタンと新規投稿フォームが表示されている' do
          expect(page).to have_content(comment.body)
          expect(page).to have_content('編集')
          expect(page).to have_content('削除')
          expect(page).to have_content('コメントを書く')
        end
      end
    end
    describe 'コメントの投稿' do
      context 'フォームの入力が正常' do
        xit 'コメントの投稿に成功する' do
          fill_in 'コメント', with: '新規コメント'
          send_keys(:tab)
          click_button 'コメントする'
          expect(page).to have_content('新規コメント')
          expect(page).to have_content('コメントを投稿しました')
        end
      end
      context 'フォームが空欄' do
        xit '投稿ボタンがdisabledにより投稿不可となる' do
          fill_in 'コメント', with: ' '
          expect(has_button?('コメントする', disabled: true)).to eq(true)
        end
      end
    end

    describe 'コメントの編集' do
      context 'フォームの入力値が正常' do
        xit 'コメントの編集が成功する' do
          click_button('編集')
          sleep 1.0
          within('#comment-edit-form') do
            fill_in 'コメント', with: '編集コメント'
          end
          click_button '更新'
          expect(page).to have_content('コメントを編集しました。')
          expect(page).to have_content('編集コメント')
        end
      end
      context 'フォームが空欄' do
        xit '投稿ボタンがdisabledにより投稿不可となる' do
          click_button('編集')
          sleep 1.0
          within('#comment-edit-form') do
            fill_in 'コメント', with: ' '
          end
          send_keys(:tab)
          expect(page).to have_content('コメント は空欄にできません。')
          expect(has_button?('更新', disabled: true)).to eq(true)
        end
      end
      context '他ユーザーのコメントを編集しようとする' do
        xit '他ユーザーのコメントに係る編集ボタンが存在しない' do
          expect(page.all('#edit-button').count).to eq 1
        end
      end
    end

    describe 'コメントの削除' do
      context '削除ボタンを押下し、ポップアップの指示に従う'
      xit '講話の削除が成功する' do
        click_button '削除'
        sleep 1.0
        click_button 'はい、削除します'
        expect(page).to have_content 'コメントを削除しました。'
        expect(page).not_to have_content comment.body
      end
      context '他人のコメントを削除しようとする'
      it '他ユーザーのコメントに係る削除ボタンが存在しない' do
        expect(page.all('#delete-button').count).to eq 1
      end
    end
  end
end
