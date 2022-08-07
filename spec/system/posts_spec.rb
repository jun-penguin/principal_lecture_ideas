require 'rails_helper'

RSpec.describe '講話の閲覧・投稿・編集・削除', type: :system, js: true do
  require 'rails_helper'

  # let(:user) { create(:user) }
  # let!(:post) { create(:post) }

  describe 'ログイン前' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user_id: user.id) }
    describe 'ページ遷移確認' do
      context '講話の新規投稿ページにアクセス' do
        xit '新規投稿ページへのアクセスが失敗し、サイトトップに遷移する' do
          visit('/create')
          expect(page).to_not have_content('新規投稿')
          expect(current_path).to eq root_path
        end
      end
      context '講話の管理ページにアクセス' do
        xit '編集ページへのアクセスが失敗し、サイトトップに遷移する' do
          visit('/postings')
          expect(page).to_not have_content('講話の管理')
          expect(current_path).to eq root_path
        end
      end
      context '講話の詳細ページにアクセス' do
        # let!(:post) { create(:post) }
        xit '講話の詳細情報が表示される' do
          visit("/post/#{post.id}")
          expect(page).to have_content(post.title)
          expect(page).to have_content(post.description)
          expect(page).to have_content(post.content)
        end
      end
      context '講話の一覧ページ（サイトトップ）にアクセス' do
        xit '講話の一覧情報が表示される' do
          post_list = create_list(:post, 3)
          visit('/')
          expect(page).to have_content post_list[0].title
          expect(page).to have_content post_list[1].title
          expect(page).to have_content post_list[2].title
        end
      end
    end
  end

  describe 'ログイン後' do
    let(:user) { create(:user) }
    before { login(user) }
    describe '講話の新規投稿' do
      before { visit('/create') }
      context 'フォームの入力値が正常' do
        xit '講話の新規作成が成功する' do
          fill_in 'タイトル', with: 'test_title'
          fill_in '講話の紹介', with: 'test_description'
          fill_in '本文', with: 'test_content'
          page.all('div.v-select__selections')[0].click
          sleep 1.0
          page.all('div.v-list-item__title')[0].click
          page.all('div.v-select__selections')[1].click
          sleep 1.0
          page.all('div.v-list-item__title')[0].click
          page.all('div.v-select__selections')[2].click
          sleep 1.0
          page.all('div.v-list-item__title')[1].click
          click_button '投稿'
          expect(page).to have_content '投稿しました'
          expect(page).to have_content 'test_title'
          expect(page).to have_content 'test_description'
          expect(current_path).to eq '/postings'
        end
      end
      context 'フォームが未入力' do
        xit 'エラーメッセージが表示される' do
          fill_in 'タイトル', with: ' '
          fill_in '講話の紹介', with: ' '
          fill_in '本文', with: ' '
          page.all('div.v-select__selections')[0].click
          page.all('div.v-text-field__slot input')[1].click
          page.all('div.v-select__selections')[1].click
          page.all('div.v-text-field__slot input')[1].click
          page.all('div.v-select__selections')[2].click
          page.all('div.v-text-field__slot input')[1].click
          expect(page).to have_content('タイトル は空欄にできません。')
          expect(page).to have_content('講話の紹介 は空欄にできません。')
          expect(page).to have_content('本文 は空欄にできません。')
          expect(page).to have_content('対象学年 は空欄にできません。')
          expect(page).to have_content('シーンタイプ は空欄にできません。')
          expect(page).to have_content('公開設定 は空欄にできません。')
        end
      end
    end

    describe '講話の編集' do
      let!(:post) { create(:post, status: 'draft', user_id: user.id) }
      before { visit("/postings/edit/#{post.id}") }
      context 'フォームの入力値が正常' do
        it '講話の編集が成功する' do
          sleep 2.0
          fill_in 'タイトル', with: 'updated_title'
          page.all('div.v-select__selections')[2].click
          sleep 1.0
          page.all('div.v-list-item__title')[1].click
          click_button '上記内容で更新する'
          expect(page).to have_content '編集しました'
          expect(page).to have_content 'updated_title'
          expect(page).to have_content '講話紹介'
          expect(current_path).to eq '/postings'
        end
      end
      context 'タイトルが未入力' do
        it 'エラーメッセージが表示される' do
          fill_in 'タイトル', with: ' '
          page.all('div.v-text-field__slot textarea')[0].click
          expect(page).to have_content 'タイトル は空欄にできません。'
        end
      end
    end

  

      context '他ユーザーの講話編集ページにアクセス' do
        let!(:other_user) { create(:user, email: 'other_user@example.com') }
        let!(:other_task) { create(:task, user_id: other_user.id ) }

        it '編集ページへのアクセスが失敗する' do
          visit edit_task_path(other_task)
          expect(page).to have_content 'Forbidden access.'
          expect(current_path).to eq root_path
        end
      end
    end

    describe '講話の削除' do
      let!(:task) { create(:task, user:) }

      it 'タスクの削除が成功する' do
        visit tasks_path
        click_link 'Destroy'
        expect(page.accept_confirm).to eq 'Are you sure?'
        expect(page).to have_content 'Task was successfully destroyed'
        expect(current_path).to eq tasks_path
        expect(page).not_to have_content task.title
      end
    end
  end

