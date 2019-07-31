require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid user should be correct" do
    user = FactoryBot.create(:user)
    assert user.valid?
  end
end
