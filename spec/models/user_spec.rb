require 'spec_helper'

describe User do
  describe "#old_password?" do
    it "returns true if the password has been used" do
      user = User.create!(:email => "a@b.com", :password => "oldpassword")

      user.password = "newpassword"
      user.save!

      user.old_password?("oldpassword").should be_true
    end
  end

  describe "callbacks" do
    it "adds the old encrypted password to the passwords table" do
      expect {
        user = User.new(:email => "a@b.com", :password => "oldpassword")
        user.save!

        user.password = "newpassword"
        user.save!
      }.to change(Password, :count).by(1)
    end
  end
end
