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
end
