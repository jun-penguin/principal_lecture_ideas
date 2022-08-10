module LoginModule
  def login(user)
    visit('/')
    click_button('ログイン')
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    page.all('div.v-text-field__slot input')[1].click
    within('#login-form') do
      click_button 'ログイン'
    end
  end
end
