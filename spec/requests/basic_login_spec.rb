require 'spec_helper'

feature 'Basic sign up and login' do
  scenario "does the sign up" do
    visit new_user_session_path
    click_link "Sign up"

    fill_in "Email", :with => "rodrigo.flores@plataformatec.com.br"
    fill_in "Password", :with => "idontusethispassword"
    fill_in "Password confirmation", :with => "idontusethispassword"

    click_button "Sign up"

    page.should have_content("Welcome! You have signed up successfully.")
  end

  scenario "does the sign in" do
    email = "rodrigo.flores@plataformatec.com.br"
    password = "idontusethispassword"
    user = User.create!(:email => email, :password => password)

    visit new_user_session_path

    fill_in "Email", :with => email
    fill_in "Password", :with => password

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
  end
end
