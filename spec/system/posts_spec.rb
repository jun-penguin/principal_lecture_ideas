require 'rails_helper'

RSpec.describe '講話の閲覧・投稿・編集・削除', type: :system, js: true do
  require 'rails_helper'

  # let(:user) { create(:user) }
  # let!(:post) { create(:post) }
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }

  describe 'ログイン前' do
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
        it '講話の一覧情報が表示される' do
          post_list = create_list(:post, 3)
          visit('/')
          expect(page).to have_content post_list[0].title
          expect(page).to have_content post_list[1].title
          expect(page).to have_content post_list[2].title
        end
      end
    end
  end


  # describe 'ログイン後' do
  #   before { login(user) }
  #   describe '講話の新規投稿' do
  #     context 'フォームの入力値が正常' do
  #       it '講話の新規作成が成功する' do
  #         visit new_task_path
  #         fill_in 'Title', with: 'test_title'
  #         fill_in 'Content', with: 'test_content'
  #         select 'doing', from: 'Status'
  #         fill_in 'Deadline', with: DateTime.new(2020, 6, 1, 10, 30)
  #         click_button 'Create Task'
  #         expect(page).to have_content 'Title: test_title'
  #         expect(page).to have_content 'Content: test_content'
  #         expect(page).to have_content 'Status: doing'
  #         expect(page).to have_content 'Deadline: 2020/6/1 10:30'
  #         expect(current_path).to eq '/tasks/1'
  #       end
  #     end

  #     context 'タイトルが未入力' do
  #       it 'タスクの新規作成が失敗する' do
  #         visit new_task_path
  #         fill_in 'Title', with: ''
  #         fill_in 'Content', with: 'test_content'
  #         click_button 'Create Task'
  #         expect(page).to have_content '1 error prohibited this task from being saved:'
  #         expect(page).to have_content "Title can't be blank"
  #         expect(current_path).to eq tasks_path
  #       end
  #     end

  #     context '登録済のタイトルを入力' do
  #       it 'タスクの新規作成が失敗する' do
  #         visit new_task_path
  #         other_task = create(:task)
  #         fill_in 'Title', with: other_task.title
  #         fill_in 'Content', with: 'test_content'
  #         click_button 'Create Task'
  #         expect(page).to have_content '1 error prohibited this task from being saved'
  #         expect(page).to have_content 'Title has already been taken'
  #         expect(current_path).to eq tasks_path
  #       end
  #     end
  #   end

  #   describe 'タスク編集' do
  #     let!(:task) { create(:task, user:) }
  #     let(:other_task) { create(:task, user:) }
  #     before { visit edit_task_path(task) }

  #     context 'フォームの入力値が正常' do
  #       it 'タスクの編集が成功する' do
  #         fill_in 'Title', with: 'updated_title'
  #         select :done, from: 'Status'
  #         click_button 'Update Task'
  #         expect(page).to have_content 'Title: updated_title'
  #         expect(page).to have_content 'Status: done'
  #         expect(page).to have_content 'Task was successfully updated.'
  #         expect(current_path).to eq task_path(task)
  #       end
  #     end

  #     context 'タイトルが未入力' do
  #       it 'タスクの編集が失敗する' do
  #         fill_in 'Title', with: nil
  #         select :todo, from: 'Status'
  #         click_button 'Update Task'
  #         expect(page).to have_content '1 error prohibited this task from being saved'
  #         expect(page).to have_content "Title can't be blank"
  #         expect(current_path).to eq task_path(task)
  #       end
  #     end

  #     context '登録済のタイトルを入力' do
  #       it 'タスクの編集が失敗する' do
  #         fill_in 'Title', with: other_task.title
  #         select :todo, from: 'Status'
  #         click_button 'Update Task'
  #         expect(page).to have_content '1 error prohibited this task from being saved'
  #         expect(page).to have_content 'Title has already been taken'
  #         expect(current_path).to eq task_path(task)
  #       end
  #     end

  #     context '他ユーザーのタスク編集ページにアクセス' do
  #       let!(:other_user) { create(:user, email: 'other_user@example.com') }
  #       let!(:other_task) { create(:task, user: other_user) }

  #       it '編集ページへのアクセスが失敗する' do
  #         visit edit_task_path(other_task)
  #         expect(page).to have_content 'Forbidden access.'
  #         expect(current_path).to eq root_path
  #       end
  #     end
  #   end

  #   describe 'タスク削除' do
  #     let!(:task) { create(:task, user:) }

  #     it 'タスクの削除が成功する' do
  #       visit tasks_path
  #       click_link 'Destroy'
  #       expect(page.accept_confirm).to eq 'Are you sure?'
  #       expect(page).to have_content 'Task was successfully destroyed'
  #       expect(current_path).to eq tasks_path
  #       expect(page).not_to have_content task.title
  #     end
  #   end
  # end
end
