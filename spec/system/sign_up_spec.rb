require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system, js: true do
  before do
    visit('/')
    click_button('新規登録')
  end
  describe '入力必須カラムのvalidationチェック' do
    context '必須カラムの入力が正常' do
      it 'ユーザーの新規作成が成功する' do
        # visit root_path
        # click_button '新規登録'
        fill_in 'ユーザー名', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        page.all('div.v-text-field__slot input')[3].click
        click_button '登録'
        expect(page).to have_content('ユーザー登録が完了しました。')
        expect(page).to have_content('マイページメニュー')
      end
    end
    context '必須カラムが未入力' do
      it 'エラーメッセージが表示される' do
        fill_in 'ユーザー名', with: ' '
        fill_in 'メールアドレス', with: ' '
        fill_in 'パスワード', with: ' '
        fill_in 'パスワード（確認用）', with: ' '
        page.all('div.v-text-field__slot input')[3].click
        expect(page).to have_content('ユーザー名 は空欄にできません。')
        expect(page).to have_content('メールアドレス は空欄にできません。')
        expect(page).to have_content('パスワード は空欄にできません。')
        expect(page).to have_content('パスワード（確認用） は空欄にできません。')
      end
    end
  end
  describe '一意性の検証' do
    let!(:user) { create(:user) }
    context '既に使用されているユーザー名を使用した場合' do
      it 'エラーメッセージが表示される' do
        # factoryによって作成したuserと同一のユーザー名を入力
        fill_in 'ユーザー名', with: '田中太郎'
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        page.all('div.v-text-field__slot input')[3].click
        click_button '登録'
        expect(page).to have_content('ユーザー登録に失敗しました。')
        expect(page).to_not have_content('マイページメニュー')
      end
    end
    context '既に使用されているメールアドレスを使用した場合' do
      it 'エラーメッセージが表示される' do
        fill_in 'ユーザー名', with: 'テストユーザー'
        # factoryによって作成したuserと同一のメールアドレスを入力
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        page.all('div.v-text-field__slot input')[3].click
        click_button '登録'
        expect(page).to have_content('ユーザー登録に失敗しました。')
        expect(page).to_not have_content('マイページメニュー')
      end
    end
  end
end
