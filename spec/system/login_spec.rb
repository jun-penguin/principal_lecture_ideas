require 'rails_helper'

RSpec.describe 'ログイン', type: :system, js: true do
  let!(:user) { create(:user) }
  before do
    visit('/')
    click_button('ログイン')
  end
  describe '入力必須カラムのvalidationチェック' do
    context '必須カラムの入力が正常' do
      it 'ログインが正常に行われる。' do
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        page.all('div.v-text-field__slot input')[1].click
        within '.v-card__text' do
          click_button 'ログイン'
        end
        expect(page).to have_content('ログインしました。')
        expect(page).to have_content('マイページメニュー')
      end
    end
    context '必須カラムが未入力' do
      it 'エラーメッセージが表示される。' do
        fill_in 'メールアドレス', with: ' '
        fill_in 'パスワード', with: ' '
        page.all('div.v-text-field__slot input')[1].click
        expect(page).to have_content('メールアドレス は空欄にできません。')
        expect(page).to have_content('パスワード は空欄にできません。')
      end
    end
  end

  describe '未登録ユーザーの検証' do
    context '登録ユーザーのものではないメールアドレスを入力した場合' do
      it 'エラーメッセージが表示される' do
        fill_in 'メールアドレス', with: 'wrong@example.com'
        fill_in 'パスワード', with: 'password'
        page.all('div.v-text-field__slot input')[1].click
        within '.v-card__text' do
          click_button 'ログイン'
        end
        expect(page).to have_content('ログインに失敗しました。')
        expect(page).to_not have_content('マイページメニュー')
      end
    end
    context '登録ユーザーのものではないパスワードを入力した場合' do
      it 'エラーメッセージが表示される' do
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'wrong_password'
        page.all('div.v-text-field__slot input')[1].click
        within '.v-card__text' do
          click_button 'ログイン'
        end
        expect(page).to have_content('ログインに失敗しました。')
        expect(page).to_not have_content('マイページメニュー')
      end
    end
  end
end
