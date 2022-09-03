require 'rails_helper'

RSpec.describe 'プロフィールの閲覧、編集機能', type: :system, js: true do
  let!(:user) { create(:user, name: 'test_name', email: 'test_user@example.com') }
  describe 'ログイン前' do
    describe 'プロフィールページの表示' do
      context 'プロフィールページにアクセスする' do
        it 'アクセスが失敗し、サイトトップに遷移する' do
          visit('/myProfile')
          expect(page).to_not have_content('ユーザープロフィール')
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      login(user)
      visit('/myProfile')
      sleep 1.0
    end
    describe 'プロフィールページの表示' do
      context 'プロフィールページにアクセスする' do
        it 'ネーム、メールアドレス等が表示される' do
          expect(page).to have_content('test_name')
          expect(page).to have_content('test_user@example.com')
        end
      end
    end
    describe 'プロフィールの編集' do
      before do
        click_button('編集する')
        sleep 1.5
      end
      context 'ネーム、自己紹介、役職、都道府県を変更する' do
        it '変更項目が更新される' do
          fill_in 'ユーザーネーム', with: 'edit_name'
          fill_in '自己紹介', with: '編集した自己紹介'
          page.all('div.v-select__selections')[0].click
          sleep 0.5
          page.all('div.v-list-item__title')[2].click
          page.all('div.v-select__selections')[1].click
          sleep 0.5
          page.all('div.v-list-item__title')[6].click
          click_button '上記内容で更新する'
          sleep 2.0
          expect(current_path).to eq('/myProfile')
          expect(page).to have_content('edit_name')
          expect(page).to have_content('編集した自己紹介')
          expect(page).to have_content('現中学校校長')
          expect(page).to have_content('山形県')
        end
      end

      context 'ユーザーネームが空欄' do
        it 'エラーメッセージが表示される' do
          fill_in 'ユーザーネーム', with: ' '
          send_keys(:tab)
          expect(page).to have_content('ユーザーネーム は空欄にできません。')
        end
      end
    end
  end
end
