module LoginSupport
  def login(user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_on 'ログイン'
  end

  def logout
    find('.navbar-toggler').click
    click_on 'ログアウト'
  end
end
