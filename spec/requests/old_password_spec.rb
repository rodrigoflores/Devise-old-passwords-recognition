require "spec_helper"

feature "Old password recognition" do
  scenario "shows a page that tells you that you are using an old password that has been changed" do
    user = User.create!(:password => "anoldpassword", :email => "user@domain.com")

    user.password = "anewpassword"
    user.save!

    visit new_user_session_path

    fill_in "Email", :with => "user@domain.com"
    fill_in "Password", :with => "anoldpassword"

    click_button "Sign in"

    save_and_open_page

    page.should have_content("You are using a password that has been changed")
  end
end
