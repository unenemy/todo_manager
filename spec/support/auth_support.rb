module AuthSupport
  def log_in(user)
    visit root_path
    fill_in "user_email", :with => user.email
    fill_in "Password", :with => "111111"
    click_button "Sign in"
  end
end
