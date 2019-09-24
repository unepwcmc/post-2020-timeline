require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid user should be valid" do
    user = FactoryBot.create(:user)
    assert user.valid?
  end

  test "user without email should be invalid" do
    user = FactoryBot.build(:user, email: "")
    assert user.invalid?
  end

  test "user without password should be invalid" do
    user = FactoryBot.build(:user, password: "")
    assert user.invalid?
  end  
end
